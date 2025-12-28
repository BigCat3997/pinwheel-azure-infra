resource "azurerm_service_plan" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  os_type             = var.os_type
  sku_name            = var.sku_name
}
