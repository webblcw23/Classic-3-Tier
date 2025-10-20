variable "web_app_name" {
  type        = string
  description = "Name of the Web App"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "app_service_plan_id" {
  type        = string
  description = "ID of the App Service Plan"
}

variable "acr_login_server" {
  type        = string
  description = "ACR login server (e.g., lewisacr.azurecr.io)"
  default     = "https://lewisacr.azurecr.io"
}

variable "image_name" {
  type        = string
  description = "Docker backend image name"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag (e.g., latest)"
}
