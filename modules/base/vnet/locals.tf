locals {
  subnets = coalesce(var.subnets, [])
}
