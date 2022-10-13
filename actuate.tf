# ----------------------------------------------------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# TFR: https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
# TFD: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# GCP: https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-architecture (Official Docs)
# GCP: https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters (api refs)
# ----------------------------------------------------------------------------------------------------------------------
module "apps_cluster" {
  source                    = "terraform-google-modules/kubernetes-engine/google"
  project_id                = module.network.project_id
  name                      = "${var.project_id}-apps"
  regional                  = true
  region                    = var.region
  network                   = module.network.network_name
  subnetwork                = var.subnet_name
  ip_range_pods             = "${var.project_id}-pods"
  ip_range_services         = "${var.project_id}-svcs"
  default_max_pods_per_node = 64
  network_policy            = true
  release_channel           = "REGULAR"
  cluster_resource_labels   = { "mesh_id" : "proj-${data.google_project.project.number}" }
  node_pools = [
    {
      name         = "${var.project_id}-apps-np"
      autoscaling  = true
      auto_upgrade = true
      min_count    = 1
      max_count    = 5
      node_count   = 2
      machine_type = "e2-standard-4"
    },
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Base Network Configuration
# TFD: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
# TFD: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# TFR: https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
# ----------------------------------------------------------------------------------------------------------------------
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

# ----------------------------------------------------------------------------------------------------------------------
# Discovery
# ----------------------------------------------------------------------------------------------------------------------
data "google_project" "project" {
  project_id = var.project_id
}