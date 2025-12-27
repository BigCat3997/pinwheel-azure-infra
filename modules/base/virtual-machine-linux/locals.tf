locals {
  os_disk_name                   = format("%s-osDisk", var.vm_name)
  secret_admin_public_key_name   = "vm-${var.vm_computer_name}-account-admin-publicKey"
  secret_admin_private_key_name  = "vm-${var.vm_computer_name}-account-admin-privateKey"
  secret_admin_password_key_name = "vm-${var.vm_computer_name}-account-admin-password"
  public_ip_id                   = var.create_public_ip ? azurerm_public_ip.this[0].id : null
  public_key                     = var.existing_public_key ? file(var.public_key_path) : tls_private_key.ssh_key.public_key_openssh
}
