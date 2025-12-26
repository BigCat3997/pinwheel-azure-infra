data "azurerm_key_vault" "existing" {
  count = var.create ? 0 : 1

  resource_group_name = var.resource_group_name
  name                = var.name
}
