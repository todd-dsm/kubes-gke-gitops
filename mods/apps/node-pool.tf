# Separately Managed Node Pool
resource "google_container_node_pool" "apps" {
  name               = "${google_container_cluster.apps.name}-np"
  location           = var.region
  cluster            = google_container_cluster.apps.name
  initial_node_count = 1

  node_config {
    # preemptible  = true
    local_ssd_count = 0
    disk_type       = "pd-standard"
    disk_size_gb    = 50
    machine_type    = var.worker_type

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

    tags = ["gke-node", google_container_cluster.apps.name]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  #  management {
  #    auto_repair  = true
  #    auto_upgrade = true
  #  }

  autoscaling {
    max_node_count = 4
    min_node_count = 0
  }


}
