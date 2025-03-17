
output "container_app_ids" {
  description = "The IDs of the created container apps"
  value       = { for name, app in azurerm_container_app.container_app : name => app.id }
}

output "container_app_environment_id" {
  description = "The ID of the container app environment"
  value       = azurerm_container_app_environment.container_app_environment.id
}
