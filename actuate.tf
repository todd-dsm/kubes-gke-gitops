# -----------------------------------------------------------------------------
# Base Network Configuration
# -----------------------------------------------------------------------------
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"

  project_id   = var.project_id
  network_name = var.network
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = var.subnetwork
      subnet_ip     = var.subnetwork_ip_range
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    (var.subnetwork) = [
      {
        range_name    = var.ip_range_pods
        ip_cidr_range = var.ip_range_pods_cidr
      },
      {
        range_name    = var.ip_range_services
        ip_cidr_range = var.ip_range_services_cidr
      }
    ]
  }
}
# -----------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# -----------------------------------------------------------------------------
module "gke" {
  source             = "terraform-google-modules/kubernetes-engine/google"
  version            = "23.1.0"
  project_id         = var.project_id
  name               = var.cluster_name
  regional           = true
  region             = var.region
  release_channel    = "REGULAR"
  network            = module.vpc.network_name
  subnetwork         = module.vpc.subnets_names[0]
  ip_range_pods      = var.ip_range_pods
  ip_range_services  = var.ip_range_services
  network_policy     = false
  cluster_dns_domain = var.dns_name
  identity_namespace = "enabled"
  # ------------------ TEST ---------------------------------------------------
  # cluster_dns_provider    = "CLOUD_DNS"
  # cluster_dns_scope       = "VPC_SCOPE"
  # cluster_resource_labels = { "mesh_id" : "proj-${var.project_number}" }
  # cluster_autoscaling = {
  #   enabled             = true
  #   autoscaling_profile = "BALANCED"
  #   min_cpu_cores       = 1
  #   max_cpu_cores       = 100
  #   min_memory_gb       = 1
  #   max_memory_gb       = 1000
  #   gpu_resources       = []
  # }
  # ------------------ TEST ---------------------------------------------------
  node_pools = [
    {
      name         = "${var.cluster_name}-np"
      autoscaling  = true
      auto_upgrade = true
      node_count   = 4
      machine_type = var.worker_type
    },
  ]
}
