output "id" {
  description = "The id of the rsv"
  value       = try(azurerm_recovery_services_vault.this[0].id, null)
}
