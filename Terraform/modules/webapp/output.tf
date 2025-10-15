# ACR Pull permission
output "webapp_identity_principal_id" {
  value = azurerm_linux_web_app.web_app.identity[0].principal_id
}


output "webapp_id" {
  value = azurerm_linux_web_app.web_app.id
}
