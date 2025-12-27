resource "azurerm_api_management_api_operation" "this" {
  resource_group_name = var.resource_group_name
  operation_id        = var.operation_id
  api_name            = var.api_name
  api_management_name = var.api_management_name
  display_name        = var.display_name
  method              = var.method
  url_template        = var.url_template

  response {
    status_code = var.response_status_code
    description = var.response_description
    representation {
      content_type = var.response_content_type
    }
  }
}

resource "azurerm_api_management_api_operation_policy" "this" {
  resource_group_name = var.resource_group_name
  api_name            = azurerm_api_management_api_operation.this.api_name
  api_management_name = azurerm_api_management_api_operation.this.api_management_name
  operation_id        = azurerm_api_management_api_operation.this.operation_id
  xml_content         = local.xml_content

  depends_on = [azurerm_api_management_api_operation.this]
}
