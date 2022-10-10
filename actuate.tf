# -----------------------------------------------------------------------------
# Base Network Configuration
# -----------------------------------------------------------------------------
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"

  project_id   = var.project_id
  network_name = "${var.project_id}-vpc"
  routing_mode = "GLOBAL"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "${var.project_id}-subnet"
      subnet_ip     = var.cidr_range
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    ("${var.project_id}-subnet") = [
      {
        range_name    = "${var.project_id}-pods"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "${var.project_id}-services"
        ip_cidr_range = "172.16.0.0/18"
      }
    ]
  }
}