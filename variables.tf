/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
#variable "network" {
#  description = "Name of the VPC Network"
#  type = string
#}

variable "min_dist_size" {
  description = "Minimum distribution size; I.E.: integer >/= 3"
  type        = number
}

variable "cidr_range" {
  description = "CIDR size/range of the target network"
  type        = string
}

/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      KUBERNETES
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "cluster_name" {
  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_apps=my-cluster-name-stage"
  type        = string
}

variable "worker_type" {
  description = "Compute Engine VM instance TYPES"
  type        = string
}

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

#variable "project_number" {
#  description = "A 13-digit number that uniquely IDs a project."
#  type        = number
#}

variable "region" {
  description = "Deployment Region; from ENV; E.G.: us-central1"
  type        = string
}

#variable "zone" {
#  description = "Deployment Zone(s); from ENV; E.G.: us-central1-a"
#  type        = string
#}
#
##variable "projectCreds" {
##  description = "Path to credentials file; from ENV; E.G.: ~/.config/gcloud/terraform.json"
##  type        = string
##}
#
variable "dns_name" {
  description = "Primary DNS name; E.G.: domain.tld"
  type        = string
}