
variable "resource_group_name" { type = string }
variable "location" { type = string }

variable "frontend_subnet_id" { type = string }
variable "backend_subnet_id" { type = string }
variable "db_subnet_id" { type = string }

variable "frontend_nsg_id" { type = string }
variable "backend_nsg_id" { type = string }
variable "db_nsg_id" { type = string }

variable "sshadmin_key" {
  type        = string
  description = "SSH Public Key for Linux VMs"
}
