variable "location" {
  description = "The location of resource"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "name" {
  description = "The name of nsg"
  type        = string
}

variable "security_rules" {
  description = "The list of security rule"
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
}

variable "subnet_id" {
  description = "The id of subnet will be attached with the nsg"
  type        = string
  default     = null
}
