# Create a SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "sql-server-lewis-test"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

# Create a SQL Database - lives on the SQL Server above
resource "azurerm_mssql_database" "sql_db" {
  name                 = "sqldb"
  server_id            = azurerm_mssql_server.sql_server.id
  sku_name             = "Basic"
  max_size_gb          = 2
  zone_redundant       = false
  collation            = "SQL_Latin1_General_CP1_CI_AS"
  read_scale           = false
  storage_account_type = "Local"
}


# Create a Private Endpoint for the SQL Server with embedded DNS Zone Group
resource "azurerm_private_endpoint" "sql_pe" {
  name                = "pe-sql"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.db_subnet_id

  private_service_connection {
    name                           = "sql-priv-conn"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}



