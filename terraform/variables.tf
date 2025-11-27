variable "namespace" {
  type    = string
  default = "iti-kotlin"
}

variable "release_name" {
  type    = string
  default = "iti-kotlin"
}

variable "chart_path" {
  type    = string
  default = "../helm/iti-kotlin"
}

variable "values_file" {
  type    = string
  default = "../helm/iti-kotlin/values.yaml"
}
