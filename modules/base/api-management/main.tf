resource "azurerm_api_management" "this" {
  resource_group_name = var.resource_group_name
  name                = var.name
  location            = var.location
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name
}
