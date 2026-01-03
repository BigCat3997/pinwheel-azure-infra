variable "location" {}

variable "create_resource_group" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = bool
  default     = true
}

variable "resource_group_name" {
  description = "The name of the resource group where the VM and its resources will be created."
  type        = string
}

variable "create_vnet" {
  description = "The name of the existing virtual network to retrieve."
  type        = bool
  default     = true
}

variable "vnet_name" {
  description = "The name of the existing virtual network to retrieve."
  type        = string
}

variable "vnet_address_space" {
  description = "A list of address prefixes for the subnet in CIDR notation."
  type        = list(string)
  default     = ["10.0.1.0/27"]
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

variable "nsg_name" {
  type = string
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
}

variable "enable_load_balancer" {
  type    = bool
  default = false
}

variable "lb_name" {
  description = "The name of the IP configuration within the Network Interface to associate with the backend pool."
  type        = string
}

variable "lb_sku" {
  description = "The name of the IP configuration within the Network Interface to associate with the backend pool."
  type        = string
  default     = "Standard"
}

variable "use_bep" {
  type    = bool
  default = false
}

variable "public_ips" {
  type = list(object({
    name              = string
    allocation_method = string
    sku               = string
  }))
  default = []
}

variable "lb_frontend_ips" {
  description = "List of frontend IP configurations for LB"
  type = list(object({
    name           = string
    public_ip_name = string
  }))
  default = []
}

variable "lb_rules" {
  description = "List of LB rules"
  type = list(object({
    name             = string
    protocol         = string
    frontend_port    = number
    backend_port     = number
    frontend_ip_name = string

    probe_name              = string
    disable_outbound_snat   = optional(bool, true)
    tcp_reset_enabled       = optional(bool, true)
    idle_timeout_in_minutes = optional(number, 30)
  }))
  default = []
}


variable "lb_nat_pools" {
  description = "List of LB NAT pools"
  type = list(object({
    name                = string
    protocol            = string
    frontend_port_start = number
    frontend_port_end   = number
    backend_port        = number
    frontend_ip_name    = string
  }))
  default = []
}

variable "lb_outbound_rules" {
  description = "List of LB outbound rules"
  type = list(object({
    name                     = string
    protocol                 = string
    frontend_ip_name         = string
    allocated_outbound_ports = number
    idle_timeout_in_minutes  = number
  }))
  default = []
}

variable "lb_probes" {
  description = "List of Load Balancer health probes"
  type = list(object({
    name     = string
    protocol = string
    port     = number
  }))
  default = []
}

variable "lb_backend_pool_id" {
  description = "Load Balancer backend address pool ID"
  type        = string
  default     = null
}

variable "lb_probe_id" {
  description = "Load Balancer health probe ID"
  type        = string
  default     = null
}

variable "nic_name" {
  description = "The ID of the Network Interface to associate with the backend pool."
  type        = string
  default     = null
}

variable "lb_backend_pool_name" {
  description = "The name for the Load Balancer backend address pool."
  type        = string
}

variable "lb_probe_name" {
  description = "The name for the Load Balancer health probe."
  type        = string
}

variable "lb_protocol_tcp" {
  description = "The protocol used for the probe and rule (Tcp or Udp)."
  type        = string
}

variable "lb_http_port" {
  description = "The HTTP port number used by the probe and load balancing rule."
  type        = number
}

variable "vmss_name" {}

variable "vmss_sku" {}

variable "vmss_number_of_instances" {
  type = number
}

variable "vmss_enable_password_auth" {
  type    = bool
  default = true
}

variable "admin_username" {}

variable "admin_password" {
  default = null
}

variable "exist_public_key_path" {}

variable "ssh_key_path" {}

variable "admin_public_key" {
  default = null
}

variable "vmss_subnet_name" {}

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
  default = "Standard_LRS"
}

variable "os_disk_caching" {
  default = "ReadWrite"
}

variable "vmss_lb_inbound_rule_names" {
  type        = list(string)
  description = "List of NAT pool names to attach to the VMSS inbound rule"
  default     = []
}

variable "enable_lb_load_rule" {
  type    = bool
  default = false
}

variable "enable_lb_inbound_rule" {
  type    = bool
  default = false
}

variable "create_recovery_services_vault" {
  type    = bool
  default = false
}

variable "recovery_services_vault_name" {
  type    = string
  default = null
}

variable "vault_sku" {
  description = "Sets the vault's SKU. Possible values include: Standard, RS0."
  type        = string
  default     = "Standard"
}
