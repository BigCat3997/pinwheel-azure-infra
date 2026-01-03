output "id" {
  description = "ID of the Load Balancer"
  value       = azurerm_lb.this.id
}

output "name" {
  description = "Name of the Load Balancer"
  value       = azurerm_lb.this.name
}

output "public_ip_id" {
  description = "ID of the Public IP associated with the Load Balancer (null if none created)"
  value       = try(azurerm_public_ip.this[0].id, null)
}

output "public_ip_address" {
  description = "Public IP address of the Load Balancer (null if none created)"
  value       = try(azurerm_public_ip.this[0].ip_address, null)
}

output "nic_id" {
  description = "ID of the NIC attached to the backend pool"
  value       = var.nic_id
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.this.id
}

output "public_ip" {
  value = try(azurerm_public_ip.this[0].ip_address, null)
}

output "lb_rule_ids" {
  description = "Map of Load Balancer rule IDs keyed by name"
  value = {
    for name, rule in azurerm_lb_rule.this :
    name => rule.id
  }
}

output "lb_nat_pool_ids" {
  description = "Map of Load Balancer inbound NAT pool IDs keyed by name"
  value = {
    for name, pool in azurerm_lb_nat_pool.this :
    name => pool.id
  }
}

output "lb_outbound_rule_ids" {
  description = "Map of Load Balancer outbound rule IDs keyed by name"
  value = {
    for name, rule in azurerm_lb_outbound_rule.this :
    name => rule.id
  }
}

output "lb_probe_ids" {
  description = "Map of Load Balancer rule IDs keyed by name"
  value = {
    for name, probe in azurerm_lb_probe.this :
    name => probe.id
  }
}
