/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                 MANAGED CONTROLLER
  ----------------------------------------------------------------------------------------------------------------------
*/
resource "google_container_cluster" "apps" {
  name                     = var.cluster_apps
  initial_node_count       = 1
  remove_default_node_pool = true

  # Default VPC with a Subnet in the target region
  location   = var.region
  network    = data.google_compute_network.default_vpc.name
  subnetwork = data.google_compute_subnetwork.default_subnets.name

  ## use this or external-dns
  #  provider = google-beta
  #  dns_config {
  #    cluster_dns        = "CLOUD_DNS"
  #    cluster_dns_scope  = "VPC_SCOPE"
  #    cluster_dns_domain = var.dns_name
  #  }

  node_config {
    local_ssd_count = 0
  }

  # For some reason the vpa wants to go from true to null?!
  lifecycle {
    ignore_changes = [vertical_pod_autoscaling]
  }
  release_channel {
    channel = "REGULAR"
  }
}

# Disco: what's the latest/stable cluster version?
data "google_container_engine_versions" "gke_versions" {
  location = var.region
}
