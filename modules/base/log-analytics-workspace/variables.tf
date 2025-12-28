variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Log retention period in days"
  type        = number
  default     = 30
}
