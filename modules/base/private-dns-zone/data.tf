data "azurerm_private_dns_zone" "this" {
  count               = var.create ? 0 : 1
  name                = var.name
  resource_group_name = var.resource_group_name
}
