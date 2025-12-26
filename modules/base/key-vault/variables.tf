variable "location" {
  description = "The location of resource"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "create" {
  description = "Create new one or use exist one"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the key vault"
  type        = string
}

variable "sku_name" {
  description = "The SKU used for the key vault"
  type        = string
  default     = "standard"
}

variable "enable_public_access" {
  description = "Controls whether the key vault is accessible from public networks"
  type        = bool
}

variable "purge_protection_enabled" {
  description = "Specifies whether purge protection is enabled for the key vault"
  type        = bool
}

variable "soft_delete_retention_days" {
  description = "The retention period, in days, for soft-deleted key vault objects"
  type        = number
}

variable "disk_encryption_enabled" {
  description = "Specifies whether the key vault can be used for disk encryption scenarios"
  type        = bool
}

variable "tenant_id" {
  description = "The tenant ID associated with the key vault"
  type        = string
}

variable "object_id" {
  description = "The object ID used to configure key vault access policies"
  type        = string
}

variable "key_permissions" {
  description = "A list of permissions to assign for key vault keys"
  type        = list(string)
  default     = []
}

variable "secret_permissions" {
  description = "A list of permissions to assign for key vault secrets"
  type        = list(string)
  default     = []
}

variable "acls_bypass" {
  description = "Specifies whether trusted services can bypass key vault network access rules"
  type        = string
}

variable "acls_default_action" {
  description = "The default action applied to key vault network access rules"
  type        = string
}

variable "secrets" {
  description = "A list of secrets to be created in the key vault"
  type = list(object({
    name         = string
    value        = string
    content_type = optional(string)
  }))
  default = []
}

variable "keys" {
  description = "A list of cryptographic keys to be created in the key vault"
  type = list(object({
    name     = string
    key_type = string
    key_size = number
    key_opts = list(string)
  }))
  default = []
}
