resource "azurerm_public_ip" "this" {
  count = var.create_public_ip ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.public_ip_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
}

resource "azurerm_network_interface" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.network_interface_name

  ip_configuration {
    name                          = var.nic_ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.nic_private_ip_allocation
    private_ip_address            = var.vm_private_ip
    public_ip_address_id          = local.public_ip_id
  }
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "random_password" "vm_admin_password" {
  length           = 32
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "!#$%&*()-_=+[]<>?"
}

resource "azurerm_key_vault_secret" "private_ssh_key" {
  name         = local.secret_admin_private_key_name
  value        = tls_private_key.ssh_key.private_key_openssh
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "public_ssh_key" {
  name         = local.secret_admin_public_key_name
  value        = tls_private_key.ssh_key.public_key_openssh
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "password" {
  name         = local.secret_admin_password_key_name
  value        = tls_private_key.ssh_key.public_key_openssh
  key_vault_id = var.key_vault_id
}

resource "azurerm_linux_virtual_machine" "this" {
  location                        = var.location
  resource_group_name             = var.resource_group_name
  name                            = var.vm_name
  computer_name                   = var.vm_computer_name
  size                            = var.vm_size
  disable_password_authentication = var.disable_password
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    public_key = local.public_key
    username   = var.admin_username
  }

  os_disk {
    name                 = local.os_disk_name
    disk_size_gb         = var.os_disk_size
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
