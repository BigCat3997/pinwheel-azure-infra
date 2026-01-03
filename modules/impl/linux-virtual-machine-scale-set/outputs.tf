output "vmss_id" {
  value = module.local_virtual_machine_scale_set_linux.id
}

output "vmss_name" {
  value = module.local_virtual_machine_scale_set_linux.name
}

output "lb_id" {
  description = "ID of the Load Balancer"
  value       = try(module.local_load_balancer[0].id, null)
}

output "lb_name" {
  description = "Name of the Load Balancer"
  value       = try(module.local_load_balancer[0].name, null)
}

output "lb_public_ip_id" {
  description = "ID of the Public IP associated with the Load Balancer (null if none created)"
  value       = try(module.local_load_balancer[0].public_ip_id, null)
}

output "lb_public_ip_address" {
  description = "Public IP address of the Load Balancer (null if none created)"
  value       = try(module.local_load_balancer[0].public_ip_address, null)
}
output "lb_rule_names" {
  description = "List of Load Balancer rule names"
  value       = keys(module.local_load_balancer[0].lb_rule_ids)
}

output "lb_nat_pool_names" {
  description = "List of Load Balancer NAT pool names"
  value       = keys(module.local_load_balancer[0].lb_nat_pool_ids)
}

output "lb_outbound_rule_names" {
  description = "List of Load Balancer outbound rule names"
  value       = keys(module.local_load_balancer[0].lb_outbound_rule_ids)
}

output "lb_probe_names" {
  description = "List of Load Balancer probe names"
  value       = keys(module.local_load_balancer[0].lb_probe_ids)
}
