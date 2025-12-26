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
  description = "The name of the vnet"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network, specified in CIDR notation"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets will be created"
  type = list(object({
    name          = string
    address_space = string
  }))
  default = []
}
