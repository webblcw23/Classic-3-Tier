variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sql_admin_username" {
  type        = string
  description = "SQL admin username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL admin password"
}

variable "db_subnet_id" {
  type        = string
  description = "Subnet ID for SQL Private Endpoint"
}

variable "private_dns_zone_id" {
  type        = string
  description = "ID of the Private DNS Zone for Azure SQL"
}

variable "sql_server_name" {
  type        = string
  description = "Name of the Azure SQL Server"
}

variable "sql_db_name" {
  type        = string
  description = "Name of the Azure SQL Database"
}

