variable "location" {
  description = "The Azure region where the resources will be created. e.g., 'West Europe' or 'East US'."
  type        = string
  default     = null
}

variable "create_resource_group" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = string
}

variable "sa_name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "sa_tier" {
  description = "Storage Account tier"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.sa_tier)
    error_message = "sa_tier must be either 'Standard' or 'Premium'."
  }
}

variable "sa_replication_type" {
  description = "Replication type of the Storage Account"
  type        = string
  default     = "LRS"

  validation {
    condition = contains(
      ["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"],
      var.sa_replication_type
    )
    error_message = "Invalid storage replication type."
  }
}

variable "asp_name" {
  description = "Name of the App Service / Service Plan"
  type        = string
}

variable "asp_os_type" {
  description = "OS type of the Service Plan (Linux or Windows)"
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.asp_os_type)
    error_message = "asp_os_type must be either 'Linux' or 'Windows'."
  }
}

variable "asp_sku_name" {
  description = "SKU name of the Service Plan (e.g. Y1, B1, P1v3)"
  type        = string
  default     = "Y1"
}


variable "law_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "law_sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  description = "Retention period for Log Analytics Workspace (days)"
  type        = number
  default     = 30

  validation {
    condition     = var.law_retention_in_days >= 30 && var.law_retention_in_days <= 730
    error_message = "law_retention_in_days must be between 30 and 730 days."
  }
}

variable "ai_name" {
  description = "Name of the Application Insights resource"
  type        = string
}

variable "ai_type" {
  description = "Application type for Application Insights"
  type        = string
  default     = "web"

  validation {
    condition     = contains(["web", "other"], var.ai_type)
    error_message = "ai_type must be 'web' or 'other'."
  }
}

variable "fa_name" {
  description = "Name of the Function App"
  type        = string
}

variable "fa_always_on" {
  type = bool
}

variable "fa_runtime_stack" {
  type = string
}

variable "fa_runtime_version" {
  type = string
}

variable "fa_monitor_diagnostic_setting_name" {
  type = string
}

variable "enable_private_access" {
  type    = bool
  default = false
}

variable "create_vnet" {
  description = "Create new one or use exist vnet"
  type        = bool
  default     = true
}

variable "vnet_name" {
  description = "The name of the vnet"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network, specified in CIDR notation"
  type        = list(string)
}

variable "vnet_subnets" {
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
}

variable "fa_subnet_name" {
  type = string
}

variable "fa_subnet_outbound_name" {
  type = string
}

variable "private_dns_zone_vnets" {
  type = list(object({
    name                = string
    resource_group_name = string
  }))
}

variable "create_pdz" {
  type    = bool
  default = false
}

variable "pdz_name" {
  description = "The name of the private dns zone"
  type        = string
}

variable "enable_vnet_outbound" {
  description = "Enable outbound VNet integration for Function App"
  type        = bool
  default     = false
}

variable "vnet_outbound_subnet_id" {
  description = "Subnet ID for Function App outbound VNet integration"
  type        = string
  default     = null
}

