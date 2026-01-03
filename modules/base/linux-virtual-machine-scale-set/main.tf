resource "tls_private_key" "ssh_key" {
  count     = !var.exist_public_key_path ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "random_password" "vm_admin_password" {
  count            = var.enable_password_auth ? 1 : 0
  length           = 32
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "!#$%&*()-_=+[]<>?"
}

resource "azurerm_linux_virtual_machine_scale_set" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  sku                 = var.sku
  instances           = var.number_of_instances

  disable_password_authentication = !var.enable_password_auth
  admin_username                  = var.admin_username
  admin_password                  = var.enable_password_auth ? coalesce(var.admin_password, random_password.vm_admin_password[0].result) : null
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.exist_public_key_path ? file(var.ssh_key_path) : coalesce(var.admin_public_key, tls_private_key.ssh_key[0].public_key_openssh)
  }

  source_image_id = var.use_image_id ? var.image_id : null
  dynamic "source_image_reference" {
    for_each = var.use_image_id ? [] : [1]
    content {
      publisher = var.image_publisher
      offer     = var.image_offer
      sku       = var.image_sku
      version   = var.image_version
    }
  }

  os_disk {
    storage_account_type = var.os_disk_sa_type
    caching              = var.os_disk_caching
  }

  network_interface {
    name    = coalesce(var.nic_name, "nic-${var.name}")
    primary = var.nic_primary

    ip_configuration {
      name      = coalesce(var.nic_ipconf_name, "ipconf-${var.name}")
      primary   = var.ipconf_primary
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = var.enable_lb_load_rule ? var.lb_backend_pool_ids : null
      load_balancer_inbound_nat_rules_ids    = var.enable_lb_inbound_rule ? var.lb_nat_pool_ids : null
    }
  }
}
