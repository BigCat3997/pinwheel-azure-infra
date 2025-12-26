output "id" {
  description = "The id of the key vault"
  value       = local.key_vault.id
}

output "name" {
  description = "The name of the key vault"
  value       = local.key_vault.name
}

output "secrets" {
  description = "A list of key vault secrets"
  value = [
    for _, secret in azurerm_key_vault_secret.this : {
      id   = secret.id
      name = secret.name
    }
  ]
}

output "keys" {
  description = "A list of key vault keys"
  value = [
    for _, key in azurerm_key_vault_key.this : {
      id   = key.id
      name = key.name
    }
  ]
}