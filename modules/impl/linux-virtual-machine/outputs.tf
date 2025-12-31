output "vm_private_ssh_key_secret_values" {
  description = "A map of Key Vault Secret IDs storing the private SSH key for each VM."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => v.private_ssh_key_secret_value
  }
  sensitive = true
}

output "vm_public_ssh_key_secret_values" {
  description = "A map of Key Vault Secret IDs storing the public SSH key for each VM."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => v.public_ssh_key_secret_value
  }
  sensitive = true
}

output "vm_admin_passwords" {
  description = "A map of the generated passwords for each VM's admin account."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => v.vm_admin_password
  }
  sensitive = true
}

output "virtual_machine_ids" {
  description = "A map of the Azure Resource IDs for all Linux Virtual Machines."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => v.virtual_machine_id
  }
}

output "virtual_machine_names" {
  description = "A map of the names for all Linux Virtual Machines."
  value = {
    for k, v in module.local_linux_virtual_machine : k => v.virtual_machine_name
  }
}

output "virtual_machine_ips" {
  description = "A map containing the private and public IP addresses for all Linux Virtual Machines."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => {
      private_ip = v.virtual_machine_private_id
      public_ip  = v.virtual_machine_public_id
    }
  }
}

output "virtual_machine_remote_by_public_ips" {
  description = "A map of the public IP addresses for all Linux Virtual Machines."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => v.remote_by_public_ip
  }
}

output "virtual_machine_nic_id" {
  description = "A map of the Azure Resource IDs for all Linux Virtual Machines."
  value = {
    for k, v in module.local_linux_virtual_machine : v.virtual_machine_name => v.nic_id
  }
}
