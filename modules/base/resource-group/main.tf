resource "azurerm_resource_group" "this" {
  count = var.create ? 1 : 0

  location = var.location
  name     = var.name
}
