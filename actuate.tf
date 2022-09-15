# -----------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# -----------------------------------------------------------------------------
module "apps" {
  source     = "./mods/apps"
  envBuild   = var.envBuild
  region     = var.region
  zone       = var.zone
  project_id = var.project_id
  cidr_range = var.cidr_range
  dns_zone   = var.dns_zone
  #  cluster_apps  = var.cluster_apps
  #  kubeNode_type = var.kubeNode_type
  minDistSize = var.minDistSize
}

# -----------------------------------------------------------------------------
# Kubernetes Cluster for Vault
# -----------------------------------------------------------------------------
//module "vault" {
//  source        = "./mods/vault"
//  envBuild      = var.envBuild
//  cluster_vault  = var.cluster_vault
//  zone          = var.zone
//  kubeNode_type = "e2-medium"
//  project       = var.project
//  region        = var.region
//  dns_zone      = var.dns_zone
//  minDistSize   = 1
//}

# -----------------------------------------------------------------------------
# test module
# -----------------------------------------------------------------------------
//module "tester" {
//  source   = "./mods/test"
//  dns_zone = var.dns_zone
//  envBuild = var.envBuild
//}