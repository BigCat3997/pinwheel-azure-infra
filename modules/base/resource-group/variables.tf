variable "create" {
  description = "Create new one or use exist one"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name for the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "The Azure region where the Resource Group will be created."
  type        = string
  default     = null
}
