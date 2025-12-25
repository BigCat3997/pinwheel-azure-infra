variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "name" {
  description = "The name of the apim"
  type        = string
}

variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher"
  type        = string
}

variable "publisher_email" {
  description = "The email of the publisher"
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the apim"
  type        = string
}
