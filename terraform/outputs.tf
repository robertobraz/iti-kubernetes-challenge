output "release_name" {
  value = module.helm_app.release_name
}

output "namespace" {
  value = var.namespace
}
