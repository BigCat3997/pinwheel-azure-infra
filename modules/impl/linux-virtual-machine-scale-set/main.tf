module "local_resource_group" {
  source = "../../base/resource-group"

  create   = var.create_resource_group
  name     = var.resource_group_name
  location = var.location
}

module "local_vnet" {
  source = "../../base/vnet"

  create              = var.create_vnet
  name                = var.vnet_name
  resource_group_name = module.local_resource_group.name
  location            = var.location
  address_space       = var.vnet_address_space
  subnets             = var.subnets

  depends_on = [module.local_resource_group]
}

module "local_nsg" {
  source = "../../base/nsg"

  name                = var.nsg_name
  resource_group_name = module.local_resource_group.name
  location            = var.location
  security_rules      = var.security_rules
  subnet_id           = module.local_vnet.subnets[var.vmss_subnet_name].id

  depends_on = [module.local_vnet]
}

module "local_load_balancer" {
  source = "../../base/load-balancer"
  count  = var.enable_load_balancer ? 1 : 0

  resource_group_name  = module.local_resource_group.name
  location             = var.location
  name                 = var.lb_name
  sku                  = var.lb_sku
  public_ips           = var.public_ips
  lb_backend_pool_name = var.lb_backend_pool_name
  lb_frontend_ips      = var.lb_frontend_ips
  use_bep              = var.use_bep
  lb_rules             = var.lb_rules
  lb_nat_pools         = var.lb_nat_pools
  lb_outbound_rules    = var.lb_outbound_rules
  lb_probes            = var.lb_probes

  depends_on = [module.local_resource_group]
}

module "local_virtual_machine_scale_set_linux" {
  source = "../../base/linux-virtual-machine-scale-set"

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.vmss_name
  sku                 = var.vmss_sku
  number_of_instances = var.vmss_number_of_instances

  use_image_id    = var.use_image_id
  image_id        = var.image_id
  image_publisher = var.image_publisher
  image_offer     = var.image_offer
  image_sku       = var.image_sku
  image_version   = var.image_version
  os_disk_sa_type = var.os_disk_sa_type
  os_disk_caching = var.os_disk_caching

  enable_password_auth  = var.vmss_enable_password_auth
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  exist_public_key_path = var.exist_public_key_path
  ssh_key_path          = var.ssh_key_path
  admin_public_key      = var.admin_public_key

  subnet_id              = module.local_vnet.subnets[var.vmss_subnet_name].id
  enable_lb_load_rule    = var.enable_lb_load_rule
  lb_backend_pool_ids    = [module.local_load_balancer[0].backend_pool_id]
  enable_lb_inbound_rule = var.enable_lb_inbound_rule
  lb_nat_pool_ids = [
    for n in var.vmss_lb_inbound_rule_names :
    lookup(module.local_load_balancer[0].lb_nat_pool_ids, n)
  ]

  depends_on = [module.local_load_balancer]
}

module "local_recovery_services_vault" {
  source = "../../base/recovery-services-vault"

  create              = var.create_recovery_services_vault
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = module.local_resource_group.name
  sku                 = var.vault_sku

  depends_on = [module.local_resource_group]
}
