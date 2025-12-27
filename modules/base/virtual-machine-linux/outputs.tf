output "private_ssh_key_secret_value" {
  description = "The ID of the Key Vault Secret storing the VM admin's private SSH key."
  value       = azurerm_key_vault_secret.private_ssh_key.value
  sensitive   = true
}

output "public_ssh_key_secret_value" {
  description = "The ID of the Key Vault Secret storing the VM admin's public SSH key."
  value       = azurerm_key_vault_secret.public_ssh_key.value
  sensitive   = true
}

output "vm_admin_password" {
  description = "The randomly generated password for the VM's admin account."
  value       = random_password.vm_admin_password.result
  sensitive   = true
}

output "virtual_machine_id" {
  description = "The ID of the Linux Virtual Machine."
  value       = azurerm_linux_virtual_machine.this.id
}

output "virtual_machine_name" {
  description = "The name of the Linux Virtual Machine."
  value       = azurerm_linux_virtual_machine.this.name
}

output "virtual_machine_private_id" {
  description = "The name of the Linux Virtual Machine."
  value       = var.vm_private_ip
}

output "virtual_machine_public_id" {
  description = "The name of the Linux Virtual Machine."
  value       = var.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "remote_by_public_ip" {
  description = "The name of the Linux Virtual Machine."
  value       = var.create_public_ip ? "ssh ${var.admin_username}@${azurerm_public_ip.this[0].ip_address}" : null
}

output "nic_id" {
  description = "The id of NIC."
  value       = azurerm_network_interface.this.id
}
