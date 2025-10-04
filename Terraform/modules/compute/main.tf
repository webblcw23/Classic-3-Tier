# Frontend NIC and VM
resource "azurerm_network_interface" "frontend_nic" {
  name                = "nic-frontend"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.frontend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

}

resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                = "vm-frontend"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.frontend_nic.id]

admin_username = "azureuser"
disable_password_authentication = true

admin_ssh_key {
  username   = "azureuser"
  public_key = var.sshadmin_key
}
  os_disk {
    name              = "osdisk-frontend"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "18.04.202309190"
}
}

# Backend NIC and VM
resource "azurerm_network_interface" "backend_nic" {
  name                = "nic-backend"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.backend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }

}

resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                = "vm-backend"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.backend_nic.id]

admin_username = "azureuser"
disable_password_authentication = true

admin_ssh_key {
  username   = "azureuser"
  public_key = var.sshadmin_key
}

  os_disk {
    name              = "osdisk-backend"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "18.04.202309190"
}
}

# Database NIC. No VM needed as using Azure SQL
resource "azurerm_network_interface" "db_nic" {
  name                = "nic-db"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.db_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}
