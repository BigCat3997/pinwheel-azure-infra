resource "azurerm_application_insights" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  application_type    = var.application_type
  workspace_id        = var.workspace_id
}
