# Variables 

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "movie-explorer-rg"
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
  default     = "uksouth"
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}


# SQL Admin Credentials
variable "sql_admin_username" {
  type        = string
  description = "SQL admin username for Azure SQL Server"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL admin password for Azure SQL Server"
  sensitive   = true
}


# Key Vault Variables
variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
  default     = "kv-lewis-secure"
}


