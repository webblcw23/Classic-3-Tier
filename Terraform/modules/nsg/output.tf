output "nsg_ids" {
  value = {
    frontend = azurerm_network_security_group.frontend_nsg.id
    backend  = azurerm_network_security_group.backend_nsg.id
    db       = azurerm_network_security_group.db_nsg.id
  }
}

output "subnet_id" {
  value = {
    frontend = var.frontend_subnet_id
    backend  = var.backend_subnet_id
    db       = var.db_subnet_id
  }
}
