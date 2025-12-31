module "local_resource_group" {
  source = "../../base/resource-group"

  create   = var.create_resource_group
  location = var.location
  name     = var.resource_group_name
}

module "local_storage_account" {
  source = "../../base/storage-account"

  location                 = var.location
  resource_group_name      = var.resource_group_name
  name                     = var.sa_name
  account_tier             = var.sa_tier
  account_replication_type = var.sa_replication_type

  depends_on = [module.local_resource_group]
}

module "local_app_service_plan" {
  source = "../../base/app-service-plan"

  location            = var.location
  resource_group_name = module.local_resource_group.name
  name                = var.asp_name
  os_type             = var.asp_os_type
  sku_name            = var.asp_sku_name

  depends_on = [module.local_resource_group]
}

module "local_log_analytics_workspace" {
  source = "../../base/log-analytics-workspace"

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.law_name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days

  depends_on = [module.local_resource_group]
}

module "local_application_insights" {
  source = "../../base/application-insights"

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.ai_name
  application_type    = var.ai_type
  workspace_id        = module.local_log_analytics_workspace.id

  depends_on = [module.local_log_analytics_workspace]
}

module "local_vnet" {
  source = "../../base/vnet"

  create              = var.create_vnet
  location            = var.location
  resource_group_name = module.local_resource_group.name
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  subnets             = var.vnet_subnets
}

module "local_vnet_private_dns_zone" {
  for_each = { for v in var.private_dns_zone_vnets : v.name => v }

  source = "../../base/vnet"

  create              = false
  resource_group_name = each.value.resource_group_name
  name                = each.value.name

  depends_on = [module.local_vnet]
}

module "local_private_dns_zone" {
  source = "../../base/private-dns-zone"

  create              = var.create_pdz
  location            = var.location
  resource_group_name = module.local_resource_group.name
  name                = var.pdz_name
  vnet_ids            = local.private_dns_zone_vnet_ids
}

module "local_function_app_linux" {
  source = "../../base/linux-function-app"

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.fa_name

  sa_name       = module.local_storage_account.name
  sa_access_key = module.local_storage_account.primary_access_key

  service_plan_id = module.local_app_service_plan.id
  always_on       = var.fa_always_on

  runtime_stack   = var.fa_runtime_stack
  runtime_version = var.fa_runtime_version

  ai_instrumentation_key = module.local_application_insights.instrumentation_key
  ai_connection_string   = module.local_application_insights.connection_string

  monitor_diagnostic_setting_name = var.fa_monitor_diagnostic_setting_name
  workspace_id                    = module.local_log_analytics_workspace.id
  enable_private_access           = var.enable_private_access
  # vnet_id                         = module.local_vnet.id
  private_endpoint_subnet_id = module.local_vnet.subnets[var.fa_subnet_name].id
  private_dns_zone_id        = module.local_private_dns_zone.id


  enable_vnet_outbound    = var.enable_vnet_outbound
  vnet_outbound_subnet_id = module.local_vnet.subnets[var.fa_subnet_outbound_name].id

  depends_on = [module.local_storage_account, module.local_application_insights, module.local_app_service_plan]
}
