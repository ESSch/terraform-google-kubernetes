resource "google_container_cluster" "node-ks" {
    name               = "node-ks"
    location           = "${var.region}-a"
    node_locations     = ["${var.region}-b", "${var.region}-c"]
    initial_node_count = 1
}

resource "google_container_node_pool" "node-ks-pool" {
    name       = "node-ks-pool"
    cluster    = google_container_cluster.node-ks.name
    location   = "${var.region}-a"
    node_count = var.node_count_zone

    node_config {
        machine_type = "n1-standard-1"
    }

    autoscaling {
        min_node_count = 1
        max_node_count = 2
    }
    depends_on = [google_container_cluster.node-ks]
}
