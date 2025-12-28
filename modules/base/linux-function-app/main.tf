resource "azurerm_linux_function_app" "this" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name

  storage_account_name       = var.sa_name
  storage_account_access_key = var.sa_access_key
  service_plan_id            = var.service_plan_id

  site_config {
    always_on = var.always_on

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
