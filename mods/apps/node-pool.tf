# Separately Managed Node Pool
resource "google_container_node_pool" "apps" {
  name       = "${google_container_cluster.apps.name}-np"
  location   = var.region
  cluster    = google_container_cluster.apps.name
  node_count = 1

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", google_container_cluster.apps.name]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
