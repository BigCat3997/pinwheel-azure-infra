locals {
  vm_disk_key_id = try([for key in module.local_key_vault.keys : key if key.name == var.kv_keys[0].name][0].id, null)
}
