variable "resource_group_name" {
  type        = string
  description = "Name of the resource group containing the API Management instance"
}

variable "operation_id" {
  type        = string
  description = "Unique ID of the API operation"
}

variable "api_name" {
  type        = string
  description = "Name of the API within API Management"
}

variable "api_management_name" {
  type        = string
  description = "Name of the API Management service"
}

variable "display_name" {
  type        = string
  description = "Display name of the API operation"
}

variable "method" {
  type        = string
  description = "HTTP method for the operation (GET, POST, etc.)"
}

variable "url_template" {
  type        = string
  description = "URL template for the operation route"
}

variable "response_status_code" {
  description = "HTTP response status code"
  type        = number
}

variable "response_description" {
  description = "Response description"
  type        = string
}

variable "response_content_type" {
  description = "Response content type"
  type        = string
}

variable "policy_file_path" {
  description = "Optional path to APIM policy XML"
  type        = string
}
