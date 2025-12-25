variable "create" {
  description = "Create new one or use exist one"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource"
  type        = string
  default     = null
}
