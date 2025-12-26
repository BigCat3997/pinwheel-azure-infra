locals {
  key_vault = var.create ? azurerm_key_vault.this[0] : data.azurerm_key_vault.existing[0]
}
