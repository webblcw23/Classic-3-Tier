terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

# Provider - Azure
provider "azurerm" {
  features {}
  subscription_id = "91c0fe80-4528-4bf2-9796-5d0f2a250518"
}
