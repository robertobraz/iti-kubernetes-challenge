resource "helm_release" "app" {
  name             = var.release_name
  namespace        = var.namespace
  chart            = var.chart_path
  create_namespace = false

  values = [
    file(var.values_file)
  ]
}
