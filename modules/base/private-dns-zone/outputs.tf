output "id" {
  description = "The ID of the Private DNS Zone"
  value       = azurerm_private_dns_zone.this[0].id
}

output "name" {
  description = "The name of the Private DNS Zone"
  value       = azurerm_private_dns_zone.this[0].name
}
