resource "azurerm_key_vault" "this" {
  count = var.create ? 1 : 0

  location                      = var.location
  resource_group_name           = var.resource_group_name
  name                          = var.name
  enabled_for_disk_encryption   = var.disk_encryption_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days
  purge_protection_enabled      = var.purge_protection_enabled
  sku_name                      = var.sku_name
  tenant_id                     = var.tenant_id
  public_network_access_enabled = var.enable_public_access

  network_acls {
    bypass         = var.acls_bypass
    default_action = var.acls_default_action
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  count = var.create ? 1 : 0

  key_vault_id = local.key_vault.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions    = var.key_permissions
  secret_permissions = var.secret_permissions

  depends_on = [azurerm_key_vault.this]
}

resource "azurerm_key_vault_secret" "this" {
  for_each = { for secret in var.secrets : secret.name => secret }

  name         = each.value.name
  value        = each.value.value
  key_vault_id = local.key_vault.id
  content_type = lookup(each.value, "content_type", null)

  depends_on = [azurerm_key_vault.this, azurerm_key_vault_access_policy.this]
}

resource "azurerm_key_vault_key" "this" {
  for_each = { for key in var.keys : key.name => key }

  name         = each.value.name
  key_vault_id = local.key_vault.id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts

  depends_on = [azurerm_key_vault.this, azurerm_key_vault_access_policy.this]
}
