output "network_name" {
  value = google_compute_network.vpc.name
}

output "subnets_names" {
  value = google_compute_subnetwork.subnet[*].name
}