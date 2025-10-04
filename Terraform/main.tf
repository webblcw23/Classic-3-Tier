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
  frontend_subnet_id     = module.network.subnet_ids["frontend"]
  backend_subnet_id      = module.network.subnet_ids["backend"]
  db_subnet_id           = module.network.subnet_ids["db"]
}

# Create VMs (incluiding NICs) using module
module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  #Subnets
  frontend_subnet_id     = module.network.subnet_ids["frontend"]
  backend_subnet_id      = module.network.subnet_ids["backend"]
  db_subnet_id           = module.network.subnet_ids["db"]
  
  #NSGs
  frontend_nsg_id       = module.nsg.nsg_ids["frontend"]
  backend_nsg_id        = module.nsg.nsg_ids["backend"]
  db_nsg_id             = module.nsg.nsg_ids["db"]

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
  source               = "./modules/sql"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  sql_admin_username   = var.sql_admin_username
  sql_admin_password   = var.sql_admin_password
  db_subnet_id         = module.network.subnet_ids["db"]
  private_dns_zone_id  = azurerm_private_dns_zone.sql_dns.id
}
