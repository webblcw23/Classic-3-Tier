# Linux web app 

resource "azurerm_linux_web_app" "backend_web_app" {
  name                = var.web_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.app_service_plan_id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name   = "${var.image_name}:${var.image_tag}"
      docker_registry_url = "https://lewisacr.azurecr.io"
    }
    container_registry_use_managed_identity = true
  }

  app_settings = {
    "WEBSITES_PORT"    = "80"
    "DOCKER_ENABLE_CI" = "true"
  }
}
