variable "location" {
  description = "The location of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "name" {
  description = "The name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "The tier of the storage account"
  type        = string
}

variable "account_replication_type" {
  description = "The replication type of the storage account"
  type        = string
}
