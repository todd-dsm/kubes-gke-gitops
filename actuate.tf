# -----------------------------------------------------------------------------
# Base Network Configuration
# -----------------------------------------------------------------------------
module "vpc" {
  source = "./mods/network"
  #  version      = "5.2.0"
  project_id    = var.project_id
  min_dist_size = var.min_dist_size
  cidr_range    = var.cidr_range
  region        = var.region
}

# -----------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# -----------------------------------------------------------------------------
#module "gke" {
#  source          = "terraform-google-modules/kubernetes-engine/google"
#  version         = "23.1.0"
#  project_id      = var.project_id
#  name            = var.cluster_name
#  regional        = true
#  region          = var.region
#  release_channel = "REGULAR"
#  network         = module.vpc.network_name
#  subnetwork      = module.vpc.subnets_names[0]
#  #  ip_range_pods      = var.ip_range_pods
#  #  ip_range_services  = var.ip_range_services
#  network_policy     = false
#  cluster_dns_domain = var.dns_name
#  identity_namespace = "enabled"
#  # ------------------ TEST ---------------------------------------------------
#  # cluster_dns_provider    = "CLOUD_DNS"
#  # cluster_dns_scope       = "VPC_SCOPE"
#  # cluster_resource_labels = { "mesh_id" : "proj-${var.project_number}" }
#  # cluster_autoscaling = {
#  #   enabled             = true
#  #   autoscaling_profile = "BALANCED"
#  #   min_cpu_cores       = 1
#  #   max_cpu_cores       = 100
#  #   min_memory_gb       = 1
#  #   max_memory_gb       = 1000
#  #   gpu_resources       = []
#  # }
#  # ------------------ TEST ---------------------------------------------------
#  node_pools = [
#    {
#      name         = "${var.cluster_name}-np"
#      autoscaling  = true
#      auto_upgrade = true
#      node_count   = 4
#      machine_type = var.worker_type
#    },
#  ]
#}

# -----------------------------------------------------------------------------
# Policy Bindings for Additional Applications
# We'll just add to the node-pool service account created in the gke module.
# TEST before/after with: gcloud projects get-iam-policy $myProject | grep $roleName
# Example: gcloud projects get-iam-policy $myProject | grep dns.admin
# -----------------------------------------------------------------------------
/*
  Permissions for External DNS; using the Worker Node Service Account method
  REF: https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/gke.md#worker-node-service-account-method
  Docs: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
*/
#resource "google_project_iam_binding" "worker_sa" {
#  project = var.project_id
#  role    = "roles/dns.admin"
#
#  members = [
#    "serviceAccount:${module.gke.service_account}",
#  ]
#}

/*
  Create a Workload Identity Pairing
  GCP: https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity
  TF:  https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/workload-identity
*/

# # Pre-existing Kubernetes SA; comes from Helm install
# resource "kubernetes_service_account" "external_dns" {
#   metadata {
#     name      = "external-dns"
#     namespace = "default"
#   }
# }

# # Pre-existing Kubernetes SA; comes from node-pool creation
# resource "google_service_account" "preexisting" {
#   account_id   = "external-dns-sax"
# }

# module "xdns-workload-identity" {
#   source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#   version    = "23.1.0"
#   name       = "external-dns"
#   namespace  = "default"
#   project_id = var.project_id
#   roles      = ["roles/storage.admin", "roles/compute.admin"]
# }


# module "xdns-workload-identity" {
#   source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#   use_existing_gcp_sa = true
#   name                = google_service_account.preexisting.account_id
#   project_id          = var.project_id

#   # wait for the custom GSA to be created to force module data source read during apply
#   # https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/issues/1059
#   depends_on = [google_service_account.preexisting]
# }
