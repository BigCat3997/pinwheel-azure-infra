resource "azurerm_virtual_network" "this" {
  count = var.create ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  for_each = { for sn in local.subnets : sn.name => sn }

  resource_group_name  = var.resource_group_name
  name                 = each.value.name
  address_prefixes     = [each.value.address_space]
  virtual_network_name = var.name

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  depends_on = [azurerm_virtual_network.this]
}
