output "endpoint" {
  value = google_container_cluster.node-ks.endpoint
  sensitive = true
}

output "name" {
  value = google_container_cluster.node-ks.name
  sensitive = true
}

output "cluster_ca_certificate" {
  value = base64decode(google_container_cluster.node-ks.master_auth.0.cluster_ca_certificate)
}
