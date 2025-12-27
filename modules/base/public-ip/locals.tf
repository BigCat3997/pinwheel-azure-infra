locals {
  public_ip = var.create ? data.azurerm_public_ip.existing[0] : azurerm_public_ip.new[0]
}
