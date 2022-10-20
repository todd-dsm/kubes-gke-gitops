#/*
#  --------------------------------------------------------|-------------------------------------------------------------
#                                                      DISCOVERY
#  TFR: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gke_hub_membership
#  ----------------------------------------------------------------------------------------------------------------------
#*/
#resource "google_gke_hub_membership" "gke_membership" {
#  membership_id = var.cluster_name
#  endpoint {
#    gke_cluster {
#      resource_link = "//container.googleapis.com/${data.google_container_cluster.apps_cluster.id}"
#    }
#  }
#  #provider = google-beta
#  depends_on = [
#    data.google_container_cluster.apps_cluster
#  ]
#}
#
## This works but could be improved
#resource "null_resource" "exec_gke_mesh" {
#  provisioner "local-exec" {
#    interpreter = ["bash", "-exc"]
#    command     = "${path.module}/scripts/mesh.sh"
#    environment = {
#      CLUSTER    = data.google_container_cluster.apps_cluster.name
#      LOCATION   = data.google_container_cluster.apps_cluster.location
#      PROJECT    = var.project_id
#      KUBECONFIG = var.kubeconfig_path
#    }
#  }
#  # build_number is just a date (2022-10-20T00:04:37Z), which changes and always triggers an apply.
#  # Doesn't seem useful at this point; it needs to be ran once only. Stop ignoring if it becomes important later.
#  triggers = {
#    build_number = timestamp()
#    script_sha1  = sha1(file("${path.module}/scripts/mesh.sh")),
#  }
#  lifecycle {
#    ignore_changes = [
#      triggers["build_number"]
#    ]
#  }
#  depends_on = [
#    data.google_container_cluster.apps_cluster
#  ]
#}
#
#/*
#  --------------------------------------------------------|-------------------------------------------------------------
#                                                      DISCOVERY
#  We need to do this because the GKE Module does not output various attributes. The convenience of the module is gained
#  but other, simple conveniences are lost.
#  ----------------------------------------------------------------------------------------------------------------------
#*/
#data "google_container_cluster" "apps_cluster" {
#  name     = var.cluster_name
#  location = var.location
#}
#
