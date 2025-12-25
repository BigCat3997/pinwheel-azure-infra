output "id" {
  description = "The id of the apim"
  value       = azurerm_api_management.this.id
}

output "name" {
  description = "The name of the apim"
  value       = azurerm_api_management.this.name
}

output "sku_name" {
  description = "The sku name of the apim"
  value       = azurerm_api_management.this.sku_name
}
