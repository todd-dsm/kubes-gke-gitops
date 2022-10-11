# -----------------------------------------------------------------------------
# Kubernetes Cluster for Applications
# -----------------------------------------------------------------------------
module "kubernetes-engine_example_simple_autopilot_public" {
  source     = "terraform-google-modules/kubernetes-engine/google//examples/simple_autopilot_public"
  version    = "23.2.0"
  project_id = var.project_id
  region     = var.region
}
