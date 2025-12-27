resource "azurerm_public_ip" "new" {
  count = var.create ? 0 : 1

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  allocation_method   = var.allocation_method
}

