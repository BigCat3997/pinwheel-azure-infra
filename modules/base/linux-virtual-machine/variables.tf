variable "location" {
  description = "The Azure region where the resources will be created. e.g., 'West Europe' or 'East US'."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to either create or use for the VM and its resources."
  type        = string
}

variable "create_public_ip" {
  type = bool
}

variable "public_ip_name" {
  description = "The name of the Azure Public IP address."
  type        = string
}

variable "public_ip_allocation_method" {
  description = "The allocation method for the Public IP. Must be 'Static' or 'Dynamic'."
  type        = string
}

variable "public_ip_sku" {
  description = "The SKU for the Public IP. Must be 'Basic' or 'Standard'."
  type        = string
}

variable "subnet_id" {
  description = "The id of the Azure Subnet."
  type        = string
}

variable "network_interface_name" {
  description = "The name of the Azure Network Interface."
  type        = string
}

variable "nic_ip_config_name" {
  description = "The name of the IP configuration within the Network Interface."
  type        = string
}

variable "nic_private_ip_allocation" {
  description = "The allocation method for the Network Interface private IP. Must be 'Static' or 'Dynamic'."
  type        = string
}

variable "vm_private_ip" {
  description = "The static private IP address to assign to the VM's network interface."
  type        = string
}

variable "disk_encryption_set_name" {
  description = "The name for the Azure Disk Encryption Set (DES) resource."
  type        = string
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault Key to use for disk encryption. This is the complete URI/ID of the key, including the Key Vault resource ID and key name, but *without* the key version."
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "The ID of the Azure Key Vault to apply the access policy to."
  type        = string
}

variable "key_vault_tenant_id" {
  description = "The Tenant ID of the Azure Key Vault. This is typically the Tenant ID of the subscription."
  type        = string
}

variable "vm_name" {
  description = "The name for the Azure Virtual Machine."
  type        = string
}

variable "vm_computer_name" {
  description = "The local computer name for the Virtual Machine operating system."
  type        = string
}

variable "disable_password" {
  description = "Set to true to disable password authentication for the VM. Defaults to true."
  type        = bool
}

variable "admin_username" {
  description = "The username for the administrator account on the VM."
  type        = string
}

variable "admin_password" {
  description = "The password for the administrator account on the VM."
  type        = string
  sensitive   = true
}

variable "existing_public_key" {
  type = bool
}

variable "public_key_path" {
  type      = string
  sensitive = true
}

variable "os_disk_size" {
  type = number
}

variable "os_disk_sku_type" {
  type = string
  validation {
    condition     = contains(["StandardSSD_LRS", "StandardSSD_ZRS", "Premium_LRS", "Premium_ZRS"], var.os_disk_sku_type)
    error_message = "Invalid name for SKU Type of Disk, please refer the name example: StandardSSD_LRS."
  }
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "os_disk_caching" {
  description = "The caching type of the OS disk."
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "The storage account type of the OS disk."
  type        = string
}

variable "image_publisher" {
  description = "The publisher of the source image to be used for the VM. e.g., 'Canonical'."
  type        = string
}

variable "image_offer" {
  description = "The offer of the source image. e.g., 'UbuntuServer'."
  type        = string
}

variable "image_sku" {
  description = "The SKU of the source image. e.g., '18.04-LTS'."
  type        = string
}

variable "image_version" {
  description = "The version of the source image. e.g., 'latest'."
  type        = string
}
