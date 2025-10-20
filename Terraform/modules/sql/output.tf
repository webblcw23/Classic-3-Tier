output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "sql_db_name" {
  value = azurerm_mssql_database.sql_db.name
}


output "sql_server_id" {
  value = azurerm_mssql_server.sql_server.id
}
