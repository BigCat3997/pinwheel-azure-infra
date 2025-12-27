resource "azurerm_api_management_api" "this" {
  resource_group_name   = var.resource_group_name
  name                  = var.name
  display_name          = var.display_name
  revision              = var.revision
  path                  = var.path
  protocols             = var.protocols
  subscription_required = var.subscription_required
  api_management_name   = var.api_management_name
}
