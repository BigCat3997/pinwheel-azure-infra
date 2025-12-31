resource "azurerm_storage_account" "this" {
  location                 = var.location
  resource_group_name      = var.resource_group_name
  name                     = var.name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  network_rules {
    default_action = var.default_action
  }
}

resource "azurerm_storage_container" "blobs" {
  for_each = { for c in var.blob_containers : c.name => c }

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = each.value.access_type
}

resource "azurerm_storage_share" "files" {
  for_each = { for f in var.file_shares : f.name => f }

  name               = each.value.name
  storage_account_id = azurerm_storage_account.this.id
  quota              = each.value.quota
}

resource "azurerm_private_endpoint" "blob" {
  count = var.create_pe_blob ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.pe_blob_name
  subnet_id           = var.pe_blob_subnet_id

  private_service_connection {
    name                           = "blob-psc"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "blob-dns"
    private_dns_zone_ids = [var.private_dns_zone_blob_id]
  }
}

resource "azurerm_private_endpoint" "file" {
  count = var.create_pe_blob ? 1 : 0

  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.pe_file_name
  subnet_id           = var.pe_file_subnet_id

  private_service_connection {
    name                           = "file-psc"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "file-dns"
    private_dns_zone_ids = [var.private_dns_zone_file_id]
  }
}
