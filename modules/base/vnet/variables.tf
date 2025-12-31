variable "location" {
  description = "The location of resource"
  type        = string
  default     = null
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
  default     = null
}

variable "subnets" {
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
  default = null
}
