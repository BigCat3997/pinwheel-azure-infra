variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "name" {
  description = "Virtual Machine Scale Set name"
  type        = string
}

variable "sku" {
  description = "VM SKU instance size"
  type        = string
}

variable "number_of_instances" {
  description = "Number of VM instances"
  type        = number
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "enable_password_auth" {
  description = "Admin username"
  type        = bool
  default     = true
}

variable "admin_password" {
  description = "Admin username"
  type        = string
  default     = null
}

variable "exist_public_key_path" {
  type    = bool
  default = true
}

variable "ssh_key_path" {
  type    = string
  default = null
}

variable "admin_public_key" {
  description = "Public SSH key"
  type        = string
  default     = null
}

variable "use_image_id" {
  type        = bool
  description = "Use source_image_id instead of marketplace image"
  default     = false
}

variable "image_id" {
  type        = string
  description = "Image Id"
  default     = null
}

variable "image_publisher" {
  type        = string
  description = "Image publisher"
  default     = null
}

variable "image_offer" {
  type        = string
  description = "Image offer"
  default     = null
}

variable "image_sku" {
  type        = string
  description = "Image SKU"
  default     = null
}

variable "image_version" {
  type        = string
  description = "Image version"
  default     = null
}

variable "os_disk_sa_type" {
  type        = string
  description = "Disk storage account type (Standard_LRS, Premium_LRS, etc.)"
  default     = "Standard_LRS"
}

variable "os_disk_caching" {
  type        = string
  description = "OS Disk caching"
  default     = "ReadWrite"
}

variable "nic_name" {
  type    = string
  default = null
}

variable "nic_primary" {
  type    = bool
  default = true
}

variable "nic_ipconf_name" {
  type    = string
  default = null
}

variable "ipconf_primary" {
  type    = bool
  default = true
}

variable "subnet_id" {
  description = "Subnet ID for the VMSS IP configuration"
  type        = string
}

variable "enable_lb_load_rule" {
  type    = bool
  default = true
}

variable "lb_backend_pool_ids" {
  description = "Load Balancer backend address pool ID"
  type        = list(string)
  default     = null
}

variable "enable_lb_inbound_rule" {
  type    = bool
  default = true
}

variable "lb_nat_pool_ids" {
  description = "Load Balancer backend address pool ID"
  type        = list(string)
  default     = null
}

variable "lb_probe_id" {
  description = "Load Balancer health probe ID"
  type        = string
  default     = null
}
