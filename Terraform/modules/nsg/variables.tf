variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources in"
  type        = string
}

variable frontend_subnet_id {
  description = "The ID of the frontend subnet"
  type        = string
}

variable backend_subnet_id {
  description = "The ID of the backend subnet"
  type        = string
}

variable db_subnet_id {
  description = "The ID of the database subnet"
  type        = string
}