/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                    VPC NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
# TFH: https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network
# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
  mtu                     = 1460
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.cidr_range
}