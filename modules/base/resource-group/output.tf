output "id" {
  description = "The ID of the Azure Resource Group"
  value       = var.create ? azurerm_resource_group.this[0].id : data.azurerm_resource_group.existing[0].id
}

output "name" {
  description = "The name of the Azure Resource Group"
  value       = var.create ? azurerm_resource_group.this[0].name : data.azurerm_resource_group.existing[0].name
}

output "location" {
  description = "The Azure region where the Resource Group is located"
  value       = var.create ? azurerm_resource_group.this[0].location : data.azurerm_resource_group.existing[0].location
}
