output "id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.this.name
}

output "primary_access_key" {
  description = "Primary access key for the Storage Account"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key for the Storage Account"
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}

output "blob_container_names" {
  description = "list of blob container names created"
  value       = keys(azurerm_storage_container.blobs)
}

output "file_share_names" {
  description = "list of file share names created"
  value       = keys(azurerm_storage_share.files)
}
