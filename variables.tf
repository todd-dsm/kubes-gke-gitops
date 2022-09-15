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

variable "zone" {
  description = "Deployment Zone(s); from ENV; E.G.: us-west2-a"
  type        = string
}

#variable "projectCreds" {
#  description = "Path to credentials file; from ENV; E.G.: ~/.config/gcloud/terraform.json"
#  type        = string
#}

variable "dns_zone" {
  description = "Primary DNS zone; E.G.: domain.tld"
  type        = string
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "cidr_range" {
  description = "CIDR range for the target VPC"
  type        = string
}

variable "minDistSize" {
  description = "Minimum number of subnets and nodes; E.G.: export TF_VAR_minDistSize=4"
  type        = number
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      KUBERNETES
  ----------------------------------------------------------------------------------------------------------------------
*/
//variable "cluster_name" {
//  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_apps=apps-stage-la"
//}

# ----------------------------------------------------------------------------------------------------------------------

#variable "cluster_apps" {
#  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_apps=apps-stage-la"
#}
#
#variable "cluster_vault" {
#  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_vault=vault-$product-stage"
#}
#
#variable "kubeNode_type" {
#  description = "GKE node pool machine type, from ENV; E.G.: export TF_VAR_kubeNode_type=n1-standard-1"
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
//    "dns.googleapis.com",                                         DNS SHOULD BE universally enabled on all projects
//  ]
//}
//variable "host_cidr" {
//  description = "CIDR block reserved for networking, from ENV; E.G.: export TF_VAR_host_cidr=10.0.16.0/20"
//}
