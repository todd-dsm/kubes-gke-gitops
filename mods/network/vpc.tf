# -----------------------------------------------------------------------------
# Base Network Configuration
# -----------------------------------------------------------------------------
# TFR: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# GCP: https://cloud.google.com/vpc/docs/vpc#subnet-ranges
resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode            = "REGIONAL"
}

# Create Subnets within the VPC
# n = count = var.min_dist_size, </= 4
# REQ: Create n number of /18 IPv4 subnets
# TFR: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-0${count.index}"
  region        = var.region
  network       = google_compute_network.vpc.id
  count         = var.min_dist_size
  ip_cidr_range = cidrsubnet(var.cidr_range, 2, count.index)

  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }

  # Logging for all Subnets
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
