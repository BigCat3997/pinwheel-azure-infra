resource "azurerm_storage_account" "this" {
  location                 = var.location
  resource_group_name      = var.resource_group_name
  name                     = var.name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}
