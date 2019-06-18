variable "region" {
    default = "europe-north1"
}

variable "project_name" {
    type = string
    default = ""
}

variable "gce_key" {
    default = "./kubernetes_key.json"
}

variable "node_count_zone" {
    default = 1
}
