/*
  --------------------------------------------------------|-------------------------------------------------------------
                                               MODULE-SCOPED VARIABLES
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "envBuild" {
  description = "Build Environment; from ENV; E.G.: envBuild=stage"
  type        = string
}

variable "project_id" {
  description = "Currently configured project ID; from ENV; E.G.: My First Project"
  type        = string
}

variable "region" {
  description = "Deployment Region; from ENV; E.G.: us-west2"
  type        = string
}

variable "zone" {
  description = "Deployment Zone(s); from ENV; E.G.: us-west2-a"
  type        = string
}

variable "dns_name" {
  description = "Primary DNS zone; E.G.: domain.tld"
  type        = string
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
#variable "cidr_range" {
#  description = "CIDR range for the target VPC"
#  type        = string
#}

variable "min_dist_size" {
  type        = number
  description = "Minimum number of subnets and nodes; E.G.: export TF_VAR_min_dist_size=4"
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      KUBERNETES
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "kubes_log_service" {
  type    = string
  default = "logging.googleapis.com/kubernetes"
}

variable "kubes_monitor_service" {
  type    = string
  default = "monitoring.googleapis.com/kubernetes"
}

variable "cluster_apps" {
  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_apps=apps-stage-la"
}

variable "worker_type" {
  description = "GKE node pool machine type, from ENV; E.G.: export TF_VAR_worker_type=n1-standard-1"
  type        = string
}

# variable "gke_username" {
#   default     = ""
#   description = "gke username"
# }

# variable "gke_password" {
#   default     = ""
#   description = "gke password"
# }
