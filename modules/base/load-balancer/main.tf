resource "azurerm_public_ip" "this" {
  for_each = { for p in var.public_ips : p.name => p }

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_lb" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
  sku                 = var.sku

  dynamic "frontend_ip_configuration" {
    for_each = var.lb_frontend_ips
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = try(azurerm_public_ip.this[frontend_ip_configuration.value.public_ip_name].id, null)
    }
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = var.lb_backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count = var.use_bep ? 0 : 1

  ip_configuration_name   = var.nic_ip_configuration_name
  network_interface_id    = var.nic_id
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}

resource "azurerm_lb_probe" "this" {
  name            = var.lb_probe_name
  loadbalancer_id = azurerm_lb.this.id
  protocol        = var.lb_protocol_tcp
  port            = var.lb_http_port
}

resource "azurerm_lb_rule" "this" {
  for_each = { for r in var.lb_rules : r.name => r }

  name                           = each.value.name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_name
  probe_id                       = azurerm_lb_probe.this.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  disable_outbound_snat          = each.value.disable_outbound_snat
  tcp_reset_enabled              = each.value.tcp_reset_enabled
  idle_timeout_in_minutes        = each.value.idle_timeout_in_minutes
}

resource "azurerm_lb_nat_pool" "this" {
  for_each = { for p in var.lb_nat_pools : p.name => p }

  resource_group_name            = var.resource_group_name
  name                           = each.value.name
  loadbalancer_id                = azurerm_lb.this.id
  frontend_ip_configuration_name = each.value.frontend_ip_name
  protocol                       = each.value.protocol
  frontend_port_start            = each.value.frontend_port_start
  frontend_port_end              = each.value.frontend_port_end
  backend_port                   = each.value.backend_port
}

resource "azurerm_lb_outbound_rule" "this" {
  for_each = { for r in var.lb_outbound_rules : r.name => r }

  name                    = each.value.name
  loadbalancer_id         = azurerm_lb.this.id
  protocol                = each.value.protocol
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id

  frontend_ip_configuration {
    name = each.value.frontend_ip_name
  }

  tcp_reset_enabled        = true
  allocated_outbound_ports = each.value.allocated_outbound_ports
  idle_timeout_in_minutes  = each.value.idle_timeout_in_minutes
}
