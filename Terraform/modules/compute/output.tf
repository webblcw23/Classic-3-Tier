output "vm_private_ips" {
  value = {
    frontend = azurerm_network_interface.frontend_nic.private_ip_address
    backend  = azurerm_network_interface.backend_nic.private_ip_address
    db       = azurerm_network_interface.db_nic.private_ip_address
  }
}
