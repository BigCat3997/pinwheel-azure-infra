locals {
  private_dns_zone_name = var.create ? azurerm_private_dns_zone.this[0].name : data.azurerm_private_dns_zone.this[0].name
  private_dns_zone_id   = var.create ? azurerm_private_dns_zone.this[0].id : data.azurerm_private_dns_zone.this[0].id
}
