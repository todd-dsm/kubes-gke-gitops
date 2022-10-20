/*
  --------------------------------------------------------|-------------------------------------------------------------
                                               MODULE-SCOPED VARIABLES
  ----------------------------------------------------------------------------------------------------------------------
*/
#variable "envBuild" {
#  description = "Build Environment; from ENV; E.G.: envBuild=stage"
#  type        = string
#}

variable "project_id" {
  description = "Currently configured project ID; from ENV; E.G.: My First Project"
  type        = string
}

#variable "region" {
#  description = "Deployment Region; from ENV; E.G.: us-west2"
#  type        = string
#}
#
#variable "dns_name" {
#  description = "Primary DNS Name; E.G.: domain.tld"
#  type        = string
#}
#
#variable "xdnsSA" {
#  description = "The account id used to generate the service account email address and a stable, unique id."
#  type        = string
#}
#
#variable "xdns_key" {
#  description = "Name of the key when using a Service Account for ExternalDNS."
#  type        = string
#}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
#variable "cidr_range" {
#  description = "CIDR range for the target VPC"
#  type        = string
#}
#
#variable "min_dist_size" {
#  type        = number
#  description = "Minimum number of subnets and nodes; E.G.: export TF_VAR_min_dist_size=4"
#}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      KUBERNETES
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "cluster_name" {
  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_name=apps-stage-la"
}

variable "location" {
  description = "This will default to whatever the value for var.region."
  type        = string
}

variable "kubeconfig_path" {
  description = "full path of the KUBECONFIG file; E.G.: ~/.kube/kubes-gke-gitops-stage.ktx"
  type        = string
}

#variable "cluster_endpoint" {
#  description = "The publicly available endpoint for the cluster; provided by the GKE module outputs."
#  type        = string
#}

#variable "kubes_log_service" {
#  type    = string
#  default = "logging.googleapis.com/kubernetes"
#}
#
#variable "kubes_monitor_service" {
#  type    = string
#  default = "monitoring.googleapis.com/kubernetes"
#}
#
#variable "cluster_name" {
#  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_name=apps-stage-la"
#}
#
#variable "worker_type" {
#  description = "GKE node pool machine type, from ENV; E.G.: export TF_VAR_worker_type=n1-standard-1"
#  type        = string
#}

# variable "gke_username" {
#   default     = ""
#   description = "gke username"
# }

# variable "gke_password" {
#   default     = ""
#   description = "gke password"
# }
