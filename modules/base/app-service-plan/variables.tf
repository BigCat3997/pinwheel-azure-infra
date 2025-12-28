variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "name" {
  description = "The name of the service plan"
  type        = string
}

variable "os_type" {
  description = "The OS type for the service plan"
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "The SKU name for the service plan"
  type        = string
  default     = "B1"
}
