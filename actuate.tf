# -----------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# -----------------------------------------------------------------------------
#resource "google_container_cluster" "apps" {
#  name             = var.project_id
#  location         = var.region
#  enable_autopilot = true
#
#  network    = module.network.network_name
#  subnetwork = module.network.subnets_names[0]
#}


#resource "google_container_cluster" "apps" {
#  #provider = google-beta
#  name             = var.project_id
#  location         = var.region
#  enable_autopilot = true
#
#  network    = module.network.network_name
#  subnetwork = module.network.subnets_names[0]
#
#  #  private_cluster_config {
#  #    enable_private_endpoint = false
#  #    enable_private_nodes    = true
#  #    master_ipv4_cidr_block  = var.subnetwork_ip_range
#  #  }
#
#  #  master_authorized_networks_config {
#  #    dynamic "cidr_blocks" {
#  #      for_each = var.authorized_source_ranges
#  #      content {
#  #        cidr_block = cidr_blocks.value
#  #      }
#  #    }
#  #  }
#
#  maintenance_policy {
#    recurring_window {
#      start_time = "2021-06-18T00:00:00Z"
#      end_time   = "2050-01-01T04:00:00Z"
#      recurrence = "FREQ=WEEKLY"
#    }
#  }
#
#  # Configuration of cluster IP allocation for VPC-native clusters
#  ip_allocation_policy {
#    cluster_secondary_range_name  = "pods"
#    services_secondary_range_name = "services"
#  }
#
#  # Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters.
#  release_channel {
#    channel = "REGULAR"
#  }
#}


# -----------------------------------------------------------------------------
# Base Network Configuration
# TFD: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# TFD: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# TFR: https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
# -----------------------------------------------------------------------------
module "network" {
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"

  project_id   = var.project_id
  network_name = "${var.project_id}-vpc"
  routing_mode = "GLOBAL"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = var.subnet_range
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    (var.subnet_name) = [
      {
        range_name    = "${var.project_id}-pods"
        ip_cidr_range = var.pod_cidr
      },
      {
        range_name    = "${var.project_id}-svcs"
        ip_cidr_range = var.svc_cidr
      },
    ]
  }
}
