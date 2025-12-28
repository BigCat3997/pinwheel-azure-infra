output "function_app_url" {
  description = "Public URL of the Function App"
  value       = module.local_function_app_linux.function_app_url
}

output "function_app_kudu_url" {
  description = "Kudu SCM URL of the Function App"
  value       = module.local_function_app_linux.function_app_kudu_url
}
