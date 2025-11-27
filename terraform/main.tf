terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }
}

module "helm_app" {
  source = "./modules/helm_app"

  release_name = var.release_name
  namespace    = kubernetes_namespace.app.metadata[0].name
  chart_path   = var.chart_path
  values_file  = var.values_file
}
