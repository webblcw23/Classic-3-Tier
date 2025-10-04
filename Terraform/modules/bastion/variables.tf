variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "bastion_subnet_id" {
  type        = string
  description = "ID of the AzureBastionSubnet"
}
