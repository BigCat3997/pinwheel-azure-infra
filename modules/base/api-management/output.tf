output "name" {
  description = "Name of the resource"
  value       = azurerm_api_management.this.name
}

output "sku_name" {
  description = "SKU of the resource"
  value       = azurerm_api_management.this.sku_name
}
