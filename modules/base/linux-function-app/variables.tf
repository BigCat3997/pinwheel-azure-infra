variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "name" {
  description = "Name of the Function App"
  type        = string
}

variable "service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "sa_name" {
  description = "Storage Account name for the Function App"
  type        = string
}

variable "sa_access_key" {
  description = "Storage Account access key"
  type        = string
  sensitive   = true
}

variable "always_on" {
  description = "Enable Always On (ignored for Consumption plan)"
  type        = bool
  default     = true
}

variable "runtime_stack" {
  description = "Runtime stack (JAVA, PYTHON, DOTNET)"
  type        = string

  validation {
    condition     = contains(["JAVA", "PYTHON", "DOTNET"], var.runtime_stack)
    error_message = "runtime_stack must be one of: JAVA, PYTHON, DOTNET."
  }
}

variable "runtime_version" {
  description = "Runtime version (e.g. Java 17, Python 3.9)"
  type        = string
}

variable "ai_instrumentation_key" {
  description = "Application Insights instrumentation key"
  type        = string
  sensitive   = true
}

variable "ai_connection_string" {
  description = "Application Insights connection string"
  type        = string
  sensitive   = true
}

variable "monitor_diagnostic_setting_name" {
  description = "Name of the diagnostic setting"
  type        = string
}

variable "workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
}
