output "id" {
  description = "The id of the resource group"
  value       = var.create ? azurerm_resource_group.this[0].id : data.azurerm_resource_group.existing[0].id
}

output "name" {
  description = "The name of the resource group"
  value       = var.create ? azurerm_resource_group.this[0].name : data.azurerm_resource_group.existing[0].name
}

output "location" {
  description = "The region where the resource group is located"
  value       = var.create ? azurerm_resource_group.this[0].location : data.azurerm_resource_group.existing[0].location
}
