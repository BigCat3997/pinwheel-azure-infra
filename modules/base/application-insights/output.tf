output "instrumentation_key" {
  description = "Application Insights instrumentation key"
  value       = azurerm_application_insights.this.instrumentation_key
  sensitive   = true
}

output "connection_string" {
  description = "Application Insights connection string"
  value       = azurerm_application_insights.this.connection_string
  sensitive   = true
}
