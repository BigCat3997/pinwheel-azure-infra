data "azurerm_public_ip" "existing" {
  count = var.create ? 1 : 0

  resource_group_name = var.resource_group_name
  name                = var.name
}

