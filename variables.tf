/*
  -----------------------------------------------------------------------------
                          Initialize/Declare Variables
                                 PROJECT-LEVEL
  -----------------------------------------------------------------------------
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

#variable "projectCreds" {
#  description = "Path to credentials file; from ENV; E.G.: ~/.config/gcloud/terraform.json"
#  type        = string
#}

variable "dns_name" {
  description = "Primary DNS Name; E.G.: domain.tld"
  type        = string
}

variable "xdnsSA" {
  description = "The account id used to generate the service account email address and a stable, unique id."
  type        = string
}

variable "xdns_key" {
  description = "Name of the key when using a Service Account for ExternalDNS."
  type        = string
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "subnet_name" {
  default = "Name of the subnet within a given vpc network."
  type    = string
}

variable "subnet_range" {
  description = "CIDR range for the target VPC"
  type        = string
}

variable "min_dist_size" {
  description = "Minimum number of subnets and nodes; E.G.: export TF_VAR_min_dist_size=4"
  type        = number
}

variable "pod_cidr" {
  default = "192.168.0.0/20"
}

variable "svc_cidr" {
  default = "172.16.0.0/24"
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      KUBERNETES
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "cluster_name" {
  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_name=apps-stage-la"
}

# ----------------------------------------------------------------------------------------------------------------------
#variable "cluster_vault" {
#  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_vault=vault-$product-stage"
#}

variable "worker_type" {
  description = "GKE node pool machine type, from ENV; E.G.: export TF_VAR_worker_type=n1-standard-1"
  type        = string
}

#variable "kubes_log_service" {
#  type    = string
#  default = "logging.googleapis.com/kubernetes"
#}
#
#variable "kubes_monitor_service" {
#  type    = string
#  default = "monitoring.googleapis.com/kubernetes"
#}

# ----------------------------------------------------------------------------------------------------------------------
//variable "kubeMaster_type" {
//  description = "GKE master machine type; from ENV; E.G.: export TF_VAR_kubeMaster_type=n1-standard-1"
//}
//
//variable "kubeMaster_count" {
//  description = "Initial number of master nodes, from ENV; E.G.: export TF_VAR_kubeMaster_count=3"
//}
//variable "project_services" {
//  type = "list"
//
//  default = [
//    "cloudresourcemanager.googleapis.com",
//    "container.googleapis.com",
//    "iam.googleapis.com",
//    "dns.googleapis.com",                 # DNS SHOULD BE universally enabled on all projects
//  ]
//}

