variable "resource_group_name" {
  type = string
}

variable "name" {
  type        = string
  description = "The name of the API"
}

variable "revision" {
  type        = string
  description = "API revision number"
}

variable "display_name" {
  type        = string
  description = "Display name of the API"
}

variable "path" {
  type        = string
  description = "The path that this API responds to"
}

variable "protocols" {
  type        = list(string)
  description = "Allowed protocols"
}

variable "subscription_required" {
  type        = bool
  description = "Is subscription required?"
}

variable "api_management_name" {
  type = string
}
