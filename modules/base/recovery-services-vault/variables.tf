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
  description = "The name of the rsv"
  type        = string
}

variable "sku" {
  description = "The sku name for the rsv"
  type        = string
}

