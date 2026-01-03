output "id" {
  value = azurerm_linux_virtual_machine_scale_set.this.id
}

output "name" {
  description = "The name of the Linux Virtual Machine."
  value       = azurerm_linux_virtual_machine_scale_set.this.name
}
