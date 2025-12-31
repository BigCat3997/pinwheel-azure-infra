output "sa_id" {
  description = "ID of the Storage Account"
  value       = module.local_storage_account.id
}

output "sa_name" {
  description = "Name of the Storage Account"
  value       = module.local_storage_account.name
}

output "sa_blob_private_fqdn" {
  description = "Private Blob endpoint FQDN"
  value       = "${module.local_storage_account.name}.${module.local_private_dns_zone_blob.name}"
}

output "sa_file_private_fqdn" {
  description = "Private File Share endpoint FQDN"
  value       = "${module.local_storage_account.name}.${module.local_private_dns_zone_file.name}"
}

output "sa_blob_containers" {
  description = "Name of the Storage Account"
  value       = module.local_storage_account.blob_container_names
}

output "sa_file_shares" {
  description = "Name of the Storage Account"
  value       = module.local_storage_account.file_share_names
}
