# -----------------------------------------------------------------------------
# Base Network Configuration
# -----------------------------------------------------------------------------
# there are bugz: https://github.com/terraform-google-modules/terraform-google-network/issues/383
# otherwise I'd just use the module
module "network" {
  source        = "./mods/network"
  cidr_range    = var.cidr_range
  min_dist_size = var.min_dist_size
  project_id    = var.project_id
  region        = var.region
}
