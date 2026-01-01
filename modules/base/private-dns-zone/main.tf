resource "azurerm_private_dns_zone" "this" {
  count               = var.create ? 1 : 0
  resource_group_name = var.resource_group_name
  name                = var.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = {
    for idx, vnet_id in var.linked_vnet_ids :
    idx => vnet_id
  }

  resource_group_name   = var.resource_group_name
  name                  = "dnslink-${substr(md5(each.value), 0, 8)}"
  private_dns_zone_name = local.private_dns_zone_name
  virtual_network_id    = each.value

  depends_on = [azurerm_private_dns_zone.this]
}
