# -----------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# -----------------------------------------------------------------------------
module "apps" {
  source        = "./mods/apps"
  envBuild      = var.envBuild
  region        = var.region
  zone          = var.zone
  project_id    = var.project_id
  cluster_apps  = var.cluster_apps
  worker_type   = var.worker_type
  min_dist_size = var.min_dist_size
  dns_name      = var.dns_name
  #cidr_range    = var.cidr_range
  #dns_zone      = var.dns_zone
}

# -----------------------------------------------------------------------------
# Kubernetes Cluster for Vault
# -----------------------------------------------------------------------------
//module "vault" {
//  source        = "./mods/vault"
//  envBuild      = var.envBuild
//  cluster_vault  = var.cluster_vault
//  zone          = var.zone
//  worker_type = "e2-medium"
//  project       = var.project
//  region        = var.region
//  dns_zone      = var.dns_zone
//  min_dist_size   = 1
//}

# -----------------------------------------------------------------------------
# test module
# -----------------------------------------------------------------------------
//module "tester" {
//  source   = "./mods/test"
//  dns_zone = var.dns_zone
//  envBuild = var.envBuild
//}
