output "id" {
  description = "The id of the virtual network"
  value       = var.create ? azurerm_virtual_network.this[0].id : data.azurerm_virtual_network.existing[0].id
}

output "name" {
  description = "The name of the virtual network"
  value       = var.create ? azurerm_virtual_network.this[0].name : data.azurerm_virtual_network.existing[0].name
}

output "address_space" {
  description = "The address space of the virtual network"
  value       = var.create ? azurerm_virtual_network.this[0].address_space : data.azurerm_virtual_network.existing[0].address_space
}

output "subnets" {
  description = "The subnets details"
  value = { for k, v in azurerm_subnet.this : k => {
    id             = v.id
    name           = v.name
    address_prefix = v.address_prefixes
    }
  }
}
