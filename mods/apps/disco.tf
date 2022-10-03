/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      DISCOVERY
  ----------------------------------------------------------------------------------------------------------------------
*/
data "google_compute_network" "default_vpc" {
  name    = "default"
  project = var.project_id
}

data "google_compute_subnetwork" "default_subnets" {
  name   = "default"
  region = var.region
}
