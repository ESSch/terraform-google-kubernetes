//provider "google" {
//    credentials = "${file(var.gce_key)}"
//    project     = var.project_name
//    region      = var.region
//}

resource "google_container_cluster" "node-ks" {
    name               = "node-ks"
    location           = "${var.region}-a"
    node_locations     = ["${var.region}-b", "${var.region}-c"]
    initial_node_count = 1
}

resource "google_container_node_pool" "node-ks-pool" {
    name       = "node-ks-pool"
    cluster    = "${google_container_cluster.node-ks.name}"
    location   = "${var.region}-a"
    node_count = var.node_count_zone

    node_config {
        machine_type = "n1-standard-1"
    }

    autoscaling {
        min_node_count = 1
        max_node_count = 2
    }
}


data "google_client_config" "default" {}
provider "kubernetes" {
    host     = google_container_cluster.node-ks.endpoint
    # host = module.k8s.endpoint

    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.node-ks.master_auth.0.cluster_ca_certificate)
    #cluster_ca_certificate = module.k8s.cluster_ca_certificate

    load_config_file = false
}

resource "kubernetes_pod" "nginx" {
    metadata {
        name = "nginx-example"
        labels = {
            App = "nginx"
        }
    }

    spec {
        container {
            image = "nginx:1.7.8"
            name  = "example"

            port {
                container_port = 80
            }
        }
    }
}

resource "kubernetes_service" "nginx" {
    metadata {
        name = "nginx-example"
    }
    spec {
        selector = {
            App = kubernetes_pod.nginx.metadata.0.labels.App
        }
        port {
            port = 80
            target_port = 80
        }

        type = "LoadBalancer"
    }
}

output "lb_ip" {
    value = kubernetes_service.nginx.load_balancer_ingress.0.ip
}
output "lb_hostname" {
    value = kubernetes_service.nginx.load_balancer_ingress.0.hostname
}