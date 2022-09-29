output "region" {
  value       = module.apps.region
  description = "GCloud Region"
}

output "project_id" {
  value       = module.apps.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = module.apps.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.apps.kubernetes_cluster_host
  description = "GKE Cluster Host"
}
