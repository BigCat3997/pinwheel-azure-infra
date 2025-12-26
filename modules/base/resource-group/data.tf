data "azurerm_resource_group" "existing" {
  count = var.create ? 0 : 1

  name = var.name
}