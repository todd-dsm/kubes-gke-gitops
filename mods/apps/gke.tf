/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                 MANAGED CONTROLLER
  ----------------------------------------------------------------------------------------------------------------------
*/
resource "google_container_cluster" "primary" {
  name             = var.cluster_apps
  location         = var.region
  enable_autopilot = true
  # logging_service    = "logging.googleapis.com/kubernetes"
  # monitoring_service = "monitoring.googleapis.com/kubernetes"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  # remove_default_node_pool = true
  # initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}
