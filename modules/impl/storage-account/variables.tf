variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "create_resource_group" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "create_vnet" {
  description = "Create new one or use exist vnet"
  type        = bool
  default     = true
}

variable "vnet_name" {
  description = "The name of the vnet"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network, specified in CIDR notation"
  type        = list(string)
}

variable "vnet_subnets" {
  description = "List of subnets with optional delegation"
  type = list(object({
    name          = string
    address_space = string

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
}

variable "sa_name" {
  description = "The name of the storage account"
  type        = string
}

variable "sa_tier" {
  description = "The tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "sa_replication_type" {
  description = "The replication type of the storage account"
  type        = string
}

variable "sa_blob_containers" {
  description = "List of blob containers with name and access type"
  type = list(object({
    name        = string
    access_type = optional(string, "private")
  }))
  default = []
}

variable "sa_file_shares" {
  description = "List of file share names to create"
  type = list(object({
    name  = string
    quota = optional(number, 50)
  }))
  default = []
}

variable "sa_default_action" {
  type    = string
  default = "Allow"
}

variable "create_pe_blob" {
  type    = bool
  default = false
}

variable "create_pe_file" {
  type    = bool
  default = false
}

variable "blob_vnet_name" {
  type    = string
  default = null
}

variable "fs_vnet_name" {
  type    = string
  default = null
}

variable "pe_blob_subnet_name" {
  type    = string
  default = null
}

variable "pe_file_subnet_name" {
  type    = string
  default = null
}

variable "private_dns_zone_vnets" {
  type = list(object({
    name                = string
    resource_group_name = string
  }))
}

variable "create_private_dns_zone" {
  type    = bool
  default = false
}

variable "create_private_dns_zone_blob" {
  type    = bool
  default = false
}

variable "pe_blob_name" {
  type    = string
  default = null
}

variable "pe_file_name" {
  type    = string
  default = null
}

variable "private_dns_zone_blob_name" {
  type    = string
  default = null
}

variable "create_private_dns_zone_file" {
  type    = bool
  default = false
}

variable "private_dns_zone_file_name" {
  type    = string
  default = null
}
