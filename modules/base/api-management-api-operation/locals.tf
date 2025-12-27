locals {
  xml_content = try(file(var.policy_file_path), file("${path.module}/policy.xml"), "")
}
