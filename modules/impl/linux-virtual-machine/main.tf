module "local_resource_group" {
  source = "../../base/resource-group"

  create   = var.create_resource_group
  name     = var.resource_group_name
  location = var.location
}

module "local_key_vault" {
  source = "../../base/key-vault"

  create                     = var.create_kv
  location                   = var.location
  resource_group_name        = module.local_resource_group.name
  name                       = var.kv_name
  sku_name                   = var.sku_name
  enable_public_access       = var.enable_public_access
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  object_id                  = data.azurerm_client_config.current.object_id
  secret_permissions         = var.kv_secret_permissions
  key_permissions            = var.kv_key_permissions
  acls_bypass                = var.acls_bypass
  acls_default_action        = var.acls_default_action
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  disk_encryption_enabled    = var.disk_encryption_enabled
  secrets                    = var.kv_secrets
  keys                       = var.kv_keys
}

module "local_vnet" {
  source = "../../base/vnet"

  create              = var.create_vnet
  resource_group_name = module.local_resource_group.name
  name                = var.vnet_name
  location            = var.location
  address_space       = var.vnet_address_space
  subnets             = var.vnet_subnets
}

module "local_nsg" {
  source = "../../base/nsg"

  name                = var.nsg_name
  resource_group_name = module.local_resource_group.name
  location            = var.location
  security_rules      = var.security_rules
  subnet_id           = module.local_vnet.subnets["subnet-0"].id

  depends_on = [module.local_vnet]
}

module "local_linux_virtual_machine" {
  for_each = { for index, config in var.vms : index => config }
  source   = "../../base/linux-virtual-machine"

  location                     = var.location
  resource_group_name          = module.local_resource_group.name
  vm_name                      = each.value.vm_name
  vm_computer_name             = each.value.vm_computer_name
  network_interface_name       = each.value.network_interface_name
  create_public_ip             = each.value.create_public_ip
  public_ip_name               = each.value.public_ip_name
  public_ip_allocation_method  = each.value.public_ip_allocation_method
  public_ip_sku                = each.value.public_ip_sku
  nic_ip_config_name           = each.value.nic_ip_config_name
  nic_private_ip_allocation    = each.value.nic_private_ip_allocation
  vm_private_ip                = each.value.vm_private_ip
  subnet_id                    = module.local_vnet.subnets[each.value.vm_subnet_name].id
  disable_password             = each.value.disable_password
  admin_username               = each.value.admin_username
  admin_password               = each.value.admin_password
  existing_public_key          = each.value.existing_public_key
  public_key_path              = each.value.ssh_key_path
  os_disk_sku_type             = each.value.os_disk_sku_type
  os_disk_size                 = each.value.os_disk_size
  vm_size                      = each.value.vm_size
  os_disk_caching              = each.value.os_disk_caching
  os_disk_storage_account_type = each.value.os_disk_storage_account_type
  disk_encryption_set_name     = each.value.disk_encryption_set_name
  image_publisher              = each.value.image_publisher
  image_offer                  = each.value.image_offer
  image_sku                    = each.value.image_sku
  image_version                = each.value.image_version
  key_vault_id                 = module.local_key_vault.id
  key_vault_tenant_id          = data.azurerm_client_config.current.tenant_id
  key_vault_key_id             = local.vm_disk_key_id

  depends_on = [module.local_key_vault, module.local_vnet]
}

module "local_recovery_services_vault" {
  source = "../../base/recovery-services-vault"

  create              = var.create_rsv
  name                = var.rsv_name
  location            = var.location
  resource_group_name = module.local_resource_group.name
  sku                 = var.rsv_sku
}
