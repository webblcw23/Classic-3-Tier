# Create Virtual Network and Subnets

# Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  name                = "VirtualNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name 
}

# Subnet 1 - FrontEnd

resource "azurerm_subnet" "subnet-frontend" {
  name                 = "subnet-frontend"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet 2 - BackEnd

resource "azurerm_subnet" "subnet-backend" {
  name                 = "subnet-backend"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Subnet 3 - DB
resource "azurerm_subnet" "subnet-db" {
  name                 = "subnet-db"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Subnet 4 - Bastion
resource "azurerm_subnet" "subnet-bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}