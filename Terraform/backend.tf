terraform {
  backend "azurerm" {
    resource_group_name   = "movie-explorer-rg"
    storage_account_name  = "lewisfuncstorage"
    container_name        = "tfstate"
    key                   = "movieexplorer-prod.tfstate"
  }
}
