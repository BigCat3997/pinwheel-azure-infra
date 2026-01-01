variable "create" {
  description = "Create new one or use exist one"
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "name" {
  description = "Base name used for Private DNS Zone and related resources"
  type        = string
}

variable "linked_vnet_ids" {
  description = "List of VNet IDs to link to the Private DNS zone"
  type        = list(string)
}
