variable "region" {
    default = "europe-north1"
}

variable "gce_key" {
    default = "./kubernetes_key.json"
}

variable "node_count_zone" {
    default = 1
}

variable "node_pull" {
    default = true
}
