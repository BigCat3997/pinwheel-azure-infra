resource "azurerm_linux_function_app" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name

  storage_account_name          = var.sa_name
  storage_account_access_key    = var.sa_access_key
  service_plan_id               = var.service_plan_id
  virtual_network_subnet_id     = var.vnet_outbound_subnet_id
  public_network_access_enabled = var.enable_private_access ? false : true

  site_config {
    always_on              = var.always_on
    vnet_route_all_enabled = var.enable_vnet_outbound

    application_stack {
      java_version   = var.runtime_stack == "JAVA" ? var.runtime_version : null
      python_version = var.runtime_stack == "PYTHON" ? var.runtime_version : null
      dotnet_version = var.runtime_stack == "DOTNET" ? var.runtime_version : null
    }
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = var.ai_instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.ai_connection_string
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "outbound" {
  count          = var.enable_vnet_outbound ? 1 : 0
  app_service_id = azurerm_linux_function_app.this.id
  subnet_id      = var.vnet_outbound_subnet_id

  depends_on = [
    azurerm_linux_function_app.this
  ]
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.monitor_diagnostic_setting_name
  target_resource_id         = azurerm_linux_function_app.this.id
  log_analytics_workspace_id = var.workspace_id

  enabled_log {
    category = "FunctionAppLogs"
  }

  enabled_log {
    category = "AppServiceAuthenticationLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_private_endpoint" "this" {
  count               = var.enable_private_access ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_linux_function_app.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "functionapp-dns"
    private_dns_zone_ids = [
      var.private_dns_zone_id
    ]
  }

  depends_on = [
    azurerm_linux_function_app.this
  ]
}
