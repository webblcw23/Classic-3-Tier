# Providers in the Provider.tf file


# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Private DNS Zone for SQL
resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

# Create ACR 
resource "azurerm_container_registry" "acr" {
  name                = "lewisacr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}


# Storage Account 
resource "azurerm_storage_account" "storage_account" {
  name                     = "lewisfuncstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container for state file
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id  = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}
# Storage Blob for state file
resource "azurerm_storage_blob" "tfstate_blob" {
  name                   = "movieexplorer-prod.tfstate"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.tfstate.name
  type                   = "Block"
  size                   = 0
}


# Create a virtual network using module
module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

# Create NSGs using module
module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  frontend_subnet_id  = module.network.subnet_ids["frontend"]
  backend_subnet_id   = module.network.subnet_ids["backend"]
  db_subnet_id        = module.network.subnet_ids["db"]
}

# Link the VNet to the Private DNS Zone (after VNet and DNS Zone created)
resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "sql-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns.name
  virtual_network_id    = module.network.vnet_id
  registration_enabled  = false
}


# Create a SQL Server using module
module "sql" {
  source              = "./modules/sql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password
  db_subnet_id        = module.network.subnet_ids["db"]
  private_dns_zone_id = azurerm_private_dns_zone.sql_dns.id
  sql_server_name     = module.sql.sql_server_name
  sql_db_name         = module.sql.sql_db_name
}


# Create a Key Vault using module
module "keyvault" {
  source              = "./modules/keyvault"
  key_vault_name      = "kv-lewis-secure"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  admin_object_id     = data.azurerm_client_config.current.object_id
}

############################### Permission Setup for SQL Access ###################################
# Assign SQL Contributor role to the (frontend) Web App's managed identity
resource "azurerm_role_assignment" "kv_access_backend" {
  principal_id         = module.backend_webapp.webapp_identity_principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = module.keyvault.key_vault_id
}

# Assign SQL Contributor role to the backend Web App's managed identity
resource "azurerm_role_assignment" "sql_access_backend" {
  principal_id         = module.backend_webapp.webapp_identity_principal_id
  role_definition_name = "Contributor"
  scope                = module.sql.sql_server_id
}




################################ Permission Setup for Key Vault Access ##################################
# Get tenant_id and object_id of current user to set as admin of Key Vault
data "azurerm_client_config" "current" {}

# Create an RBAC group for Key Vault access
resource "azuread_group" "kv_access_group" {
  display_name     = "KeyVaultAccessGroup"
  security_enabled = true
}

data "azuread_user" "lewis" {
  user_principal_name = "webblcw23_hotmail.com#EXT#@webblcw23hotmail.onmicrosoft.com"
}

# Add current user to the Key Vault access group
resource "azuread_group_member" "lewis_in_group" {
  group_object_id  = azuread_group.kv_access_group.object_id
  member_object_id = data.azuread_user.lewis.object_id
}

# Assign Key Vault access policy to the access group
resource "azurerm_role_assignment" "kv_group_access" {
  scope                = module.keyvault.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_group.kv_access_group.object_id
}


################################ Web App Setup ##################################

# App service plan in the root
resource "azurerm_service_plan" "webapp_plan" {
  name                = "lewis-webapp-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

# Create a Web App using module
module "webapp" {
  source              = "./modules/webapp"
  resource_group_name = var.resource_group_name
  location            = var.location
  app_service_plan_id = azurerm_service_plan.webapp_plan.id
  acr_login_server    = azurerm_container_registry.acr.login_server

  image_name   = "movieexplorer-frontend"
  image_tag    = "latest"
  web_app_name = "MovieExplorerAppFrontend"
}

resource "azurerm_app_service_virtual_network_swift_connection" "webapp_vnet" {
  app_service_id = module.webapp.webapp_id
  subnet_id      = module.network.subnet_ids["frontend_integration"]
}



# Assign ACR Pull role to the Web App's managed identity
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = module.webapp.webapp_identity_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}



################################ Backend API Setup ##################################
module "backend_webapp" {
  source              = "./modules/backend_webapp"
  resource_group_name = var.resource_group_name
  location            = var.location
  app_service_plan_id = azurerm_service_plan.webapp_plan.id
  acr_login_server    = azurerm_container_registry.acr.login_server
  sql_server_name     = module.sql.sql_server_name
  sql_db_name         = module.sql.sql_db_name
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password


  image_name   = "movieexplorer-backend"
  image_tag    = "latest"
  web_app_name = "MovieExplorerAppBackend"
}

# Link backend web app to VNet and backend subnet 
resource "azurerm_app_service_virtual_network_swift_connection" "backend_vnet" {
  app_service_id = module.backend_webapp.webapp_id
  subnet_id      = module.network.subnet_ids["backend"]
}

# Assign ACR Pull role to the backend Web App's managed identity
resource "azurerm_role_assignment" "acr_pull_backend" {

  principal_id         = module.backend_webapp.webapp_identity_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

# Assign ACR Pull role to the frontend Web App's managed identity
resource "azurerm_role_assignment" "acr_pull_frontend" {

  principal_id         = module.webapp.webapp_identity_principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}






