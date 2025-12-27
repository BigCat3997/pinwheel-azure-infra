resource "azurerm_recovery_services_vault" "this" {
  count = var.create ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  sku                 = var.sku

  identity {
    type = "SystemAssigned"
  }
}
