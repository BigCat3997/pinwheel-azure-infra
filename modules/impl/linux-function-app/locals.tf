locals {
  private_dns_zone_vnet_ids = [
    for vnet in module.local_vnet_private_dns_zone :
    vnet.id
  ]
}
