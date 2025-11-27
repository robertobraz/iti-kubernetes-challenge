variable "release_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "chart_path" {
  type = string
}

variable "values_file" {
  type = string
}

variable "kubeconfig" {
  type    = string
  default = "~/.kube/config"
}
