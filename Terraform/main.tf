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

# Create VMs (incluiding NICs) using module
module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  #Subnets
  frontend_subnet_id = module.network.subnet_ids["frontend"]
  backend_subnet_id  = module.network.subnet_ids["backend"]
  db_subnet_id       = module.network.subnet_ids["db"]

  #NSGs
  frontend_nsg_id = module.nsg.nsg_ids["frontend"]
  backend_nsg_id  = module.nsg.nsg_ids["backend"]
  db_nsg_id       = module.nsg.nsg_ids["db"]

  #Pass through passwords from tfvars for each VM
  sshadmin_key = var.sshadmin_key
}
# Create a Bastion host using module
module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  bastion_subnet_id   = module.network.subnet_ids["bastion"]
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

  image_name   = "rangersapp"
  image_tag    = "latest"
  web_app_name = "lewisRangersApp"
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





