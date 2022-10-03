## VPC

#resource "google_compute_network" "vpc" {
#  name = data.google_compute_network.default_vpc.name
#  mtu  = 1500
#}


#resource "google_compute_network" "vpc" {
#  name                    = "${var.project_id}-vpc"
#  routing_mode            = "REGIONAL"
#  auto_create_subnetworks = "false"
#
#}
#
## Subnet
#resource "google_compute_subnetwork" "subnet" {
#  name          = "${var.project_id}-subnet"
#  region        = var.region
#  network       = google_compute_network.vpc.name
#  ip_cidr_range = var.cidr_range
#}
