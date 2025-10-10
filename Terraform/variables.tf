# Variables 

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Network-Proj-RG"
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

# VM Admin Passwords - so they are not hardcoded in main.tf
variable "sshadmin_key" {
  description = "SSH Public Key for Linux VMs"
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
}

# Key Vault Variables
variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
  default     = "kv-lewis-secure"
}


