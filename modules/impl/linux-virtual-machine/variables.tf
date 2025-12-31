variable "location" {
  description = "The Azure region where the resources will be created. e.g., 'West Europe' or 'East US'."
  type        = string
}

variable "create_resource_group" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = string
}

variable "create_kv" {
  description = "Set to true to create a new Key Vault, or false to use an existing one."
  type        = bool
}

variable "kv_name" {
  description = "The name of the Azure Key Vault instance. The name must be globally unique across all of Azure."
  type        = string
}

variable "kv_secrets" {
  description = "A list of secret objects to create in the Key Vault."
  type = list(object({
    name         = string
    value        = string
    content_type = optional(string)
  }))
  default = []
}

variable "kv_key_permissions" {
  description = "A list of permissions to assign for key vault keys"
  type        = list(string)
  default     = []
}

variable "kv_secret_permissions" {
  description = "A list of permissions to assign for key vault secrets"
  type        = list(string)
  default     = []
}

variable "enable_public_access" {
  description = "If set to 'false' (default), public network access is disabled, forcing access via Private Endpoints. Set to 'true' to allow access from all networks."
  type        = bool
  default     = true
}

variable "disk_encryption_enabled" {
  description = "Whether Azure Disk Encryption (ADE) should be enabled for this Key Vault."
  type        = bool
  default     = false
}

variable "purge_protection_enabled" {
  description = "Whether Purge Protection should be enabled for this Key Vault. Setting this to 'true' prevents immediate and irreversible deletion."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This value must be between 7 and 90 days."
  type        = number
  default     = 7
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are 'standard' (default) and 'premium'."
  type        = string
}

variable "acls_bypass" {
  description = "Specifies which Microsoft service can bypass the Network ACLs. Must be 'AzureServices' (default) or 'None'."
  type        = string
}

variable "acls_default_action" {
  description = "The default action when no IP rules or Virtual Network rules match. Must be 'Allow' (default) or 'Deny'."
  type        = string
}

variable "kv_keys" {
  description = "A list of Key Vault key definitions."
  type = list(object({
    name     = string
    key_type = string
    key_size = number
    key_opts = list(string)
  }))
  default = []
}

variable "create_vnet" {
  description = "The name of the existing virtual network to retrieve."
  type        = bool
  default     = true
}

variable "vnet_name" {
  description = "The name of the existing virtual network to retrieve."
  type        = string
}

variable "vnet_address_space" {
  description = "A list of address prefixes for the subnet in CIDR notation."
  type        = list(string)
}

variable "create_subnet" {
  description = "The name of the existing virtual network to retrieve."
  type        = bool
  default     = true
}

variable "vnet_subnets" {
  description = "List of subnets to create"
  type = list(object({
    name          = string
    address_space = string
  }))
  default = []
}

variable "nsg_name" {
  type = string
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "vms" {
  description = "A list of objects defining the configuration for each Azure Virtual Machine instance."
  type = list(object(
    {
      vm_name               = string
      vm_computer_name      = string
      vm_size               = string
      disable_password      = optional(bool, false)
      admin_username        = string
      admin_password        = string
      existing_public_key   = optional(bool, false)
      is_using_ssh_key_path = optional(bool, false)
      ssh_key_path          = optional(string, null)

      create_public_ip            = optional(bool, false)
      public_ip_name              = optional(string, null)
      public_ip_allocation_method = optional(string, null)
      public_ip_sku               = optional(string, null)
      network_interface_name      = string
      nic_ip_config_name          = string
      nic_private_ip_allocation   = string
      vm_private_ip               = string
      vm_subnet_name              = string

      os_disk_size                 = number
      os_disk_sku_type             = string
      os_disk_caching              = string
      os_disk_storage_account_type = string
      disk_encryption_set_name     = string

      image_publisher = string
      image_offer     = string
      image_sku       = string
      image_version   = string
    }
  ))

  default = []
}

variable "create_rsv" {
  type    = bool
  default = false
}

variable "rsv_name" {
  type = string
}

variable "rsv_sku" {
  description = "Sets the vault's SKU. Possible values include: Standard, RS0."
  type        = string
  default     = "Standard"
}
