module "local_resource_group" {
  source = "../../base/resource-group"

  create   = var.create_resource_group
  location = var.location
  name     = var.resource_group_name
}

module "local_vnet_sa" {
  source = "../../base/vnet"

  create              = var.create_vnet
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  subnets             = var.vnet_subnets

  depends_on = [module.local_resource_group]
}


module "local_vnet_private_dns_zone" {
  for_each = { for v in var.private_dns_zone_vnets : v.name => v }

  source = "../../base/vnet"

  create              = false
  resource_group_name = each.value.resource_group_name
  name                = each.value.name

  depends_on = [module.local_vnet_sa]
}

module "local_private_dns_zone_blob" {
  source = "../../base/private-dns-zone"

  create              = var.create_private_dns_zone_blob
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.private_dns_zone_blob_name
  linked_vnet_ids     = local.private_dns_zone_vnet_ids

  depends_on = [module.local_vnet_private_dns_zone]
}

module "local_private_dns_zone_file" {
  source = "../../base/private-dns-zone"

  create              = var.create_private_dns_zone_file
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.private_dns_zone_file_name
  linked_vnet_ids            = local.private_dns_zone_vnet_ids

  depends_on = [module.local_vnet_private_dns_zone]
}

module "local_storage_account" {
  source = "../../base/storage-account"

  location            = var.location
  resource_group_name = var.resource_group_name

  name                     = var.sa_name
  account_tier             = var.sa_tier
  account_replication_type = var.sa_replication_type

  create_pe_blob           = var.create_pe_blob
  pe_blob_name             = var.pe_blob_name
  pe_blob_subnet_id        = module.local_vnet_sa.subnets[var.pe_blob_subnet_name].id
  private_dns_zone_blob_id = module.local_private_dns_zone_blob.id
  create_pe_file           = var.create_pe_file
  pe_file_name             = var.pe_file_name
  pe_file_subnet_id        = module.local_vnet_sa.subnets[var.pe_file_subnet_name].id
  private_dns_zone_file_id = module.local_private_dns_zone_file.id

  blob_containers = var.sa_blob_containers
  file_shares     = var.sa_file_shares

  depends_on = [
    module.local_vnet_sa,
    module.local_private_dns_zone_blob,
    module.local_private_dns_zone_file
  ]
}
