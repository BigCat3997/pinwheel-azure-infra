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

variable "blob_containers" {
  description = "List of blob containers with name and access type"
  type = list(object({
    name        = string
    access_type = optional(string, "private")
  }))
  default = []
}

variable "file_shares" {
  description = "List of file share names to create"
  type = list(object({
    name  = string
    quota = optional(number, 50)
  }))
  default = []
}

variable "default_action" {
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

variable "pe_blob_name" {
  type    = string
  default = null
}

variable "pe_file_name" {
  type    = string
  default = null
}

variable "pe_blob_subnet_id" {
  type    = string
  default = null
}

variable "pe_file_subnet_id" {
  type    = string
  default = null
}
variable "private_dns_zone_blob_id" {
  type    = string
  default = null
}

variable "private_dns_zone_file_id" {
  type    = string
  default = null
}
