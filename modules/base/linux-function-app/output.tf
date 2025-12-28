output "function_app_url" {
  description = "The URL of the Azure Function App"
  value       = "https://${azurerm_linux_function_app.this.default_hostname}"
}

output "function_app_kudu_url" {
  description = "Kudu (SCM) URL where Function App files are stored"
  value       = "https://${azurerm_linux_function_app.this.name}.scm.azurewebsites.net"
}
