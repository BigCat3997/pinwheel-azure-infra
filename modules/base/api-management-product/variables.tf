variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "api_management_name" {
  description = "The name of the API Management service"
  type        = string
}

variable "product_id" {
  type        = string
  description = "API Product ID"
}

variable "display_name" {
  type        = string
  description = "Display name of the API product"
}

variable "subscription_required" {
  type        = bool
  description = "Whether a subscription is required"
}

variable "approval_required" {
  type        = bool
  description = "Whether subscription approval is required"
}

variable "published" {
  type        = bool
  description = "Whether the product is published"
}

variable "subscriptions_limit" {
  type        = number
  description = "Max number of subscriptions"
}
