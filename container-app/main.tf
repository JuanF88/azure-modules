provider "azurerm" {
  features {}
  subscription_id = "ed650814-527f-4ad3-98f7-9af062cc8adf"
}

data "azurerm_resource_group" "container_app_rg" {
  name = var.resource_group_name
}

locals {
  tfModule          = "Example"
  tfModule_extended = var.terraform_module != "" ? join(" ", [var.terraform_module, local.tfModule]) : local.tfModule

  default_location = "Brazil South"
  common_tags = {
    environment = "dev"
    project     = "container-app-demo"
  }
}


resource "azurerm_container_app_environment" "container_app_environment" {
  name                = var.container_app_env_name
  location            = data.azurerm_resource_group.container_app_rg.location
  resource_group_name = data.azurerm_resource_group.container_app_rg.name

  dapr_application_insights_connection_string = null
  infrastructure_resource_group_name          = null
  infrastructure_subnet_id                    = null
  mutual_tls_enabled                          = false
  tags                                        = var.tags
}

resource "azurerm_container_app" "container_app" {
  for_each = var.container_apps

  name                         = each.value.name
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = data.azurerm_resource_group.container_app_rg.name
  revision_mode                = each.value.revision_mode
  workload_profile_name        = null
  tags                         = each.value.tags

  template {
    container {
      name   = each.value.container_name
      image  = each.value.container_image
      cpu    = each.value.cpu
      memory = each.value.memory
    }
  }

  depends_on = [azurerm_container_app_environment.container_app_environment]
}