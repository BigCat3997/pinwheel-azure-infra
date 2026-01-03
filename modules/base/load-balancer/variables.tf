variable "location" {
  description = "The name of the Resource Group where the Key Vault and related resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Key Vault and related resources will be deployed."
  type        = string
}

variable "public_ips" {
  type = list(object({
    name              = string
    allocation_method = string
    sku               = string
  }))
  default = []
}

variable "name" {
  description = "The name of the IP configuration within the Network Interface to associate with the backend pool."
  type        = string
}

variable "sku" {
  description = "The name of the IP configuration within the Network Interface to associate with the backend pool."
  type        = string
}

variable "lb_backend_pool_name" {
  description = "The name for the Load Balancer backend address pool."
  type        = string
}

variable "lb_probe_name" {
  description = "The name for the Load Balancer health probe."
  type        = string
  default     = "http-probe-80"
}

variable "lb_protocol_tcp" {
  description = "The protocol used for the probe and rule (Tcp or Udp)."
  type        = string
  default     = "Tcp"
}

variable "lb_http_port" {
  description = "The HTTP port number used by the probe and load balancing rule."
  type        = number
  default     = 80
}

variable "use_bep" {
  description = "The name of the IP configuration within the Network Interface to associate with the backend pool."
  type        = bool
  default     = false
}

variable "nic_ip_configuration_name" {
  description = "The name of the IP configuration within the Network Interface to associate with the backend pool."
  type        = string
  default     = null
}

variable "nic_id" {
  description = "The ID of the Network Interface to associate with the backend pool."
  type        = string
  default     = null
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
  description = "List of Load Balancer rules"
  type = list(object({
    name                    = string
    protocol                = string
    frontend_port           = number
    backend_port            = number
    frontend_ip_name        = string
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
