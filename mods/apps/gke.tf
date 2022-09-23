/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                 MANAGED CONTROLLER
  ----------------------------------------------------------------------------------------------------------------------
*/
resource "google_container_cluster" "primary" {
  provider         = google-beta
  name             = var.cluster_apps
  location         = var.region
  enable_autopilot = true

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  dns_config {
    cluster_dns        = "CLOUD_DNS"
    cluster_dns_scope  = "VPC_SCOPE"
    cluster_dns_domain = var.dns_name
  }
}
