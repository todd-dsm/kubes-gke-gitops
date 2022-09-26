/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/
variable "network" {
  description = "Name of the VPC Network"
  default     = "asm-vpc"
}

variable "subnetwork" {
  description = "Subnet Name"
  default     = "subnet-01"
}

variable "subnetwork_ip_range" {
  description = "subnet CIDR"
  default     = "10.10.10.0/24"
}

variable "ip_range_pods" {
  default = "subnet-01-pods"
}

variable "ip_range_pods_cidr" {
  default = "10.100.0.0/16"
}

variable "ip_range_services" {
  default = "subnet-01-services"
}

variable "ip_range_services_cidr" {
  default = "10.101.0.0/16"
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

variable "cluster_name" {
  description = "Display name in GKE and kubectl; from ENV; E.G.: TF_VAR_cluster_apps=apps-stage-la"
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

variable "project_number" {
  description = "A 13-digit number that uniquely IDs a project."
  type        = number
}

variable "region" {
  description = "Deployment Region; from ENV; E.G.: us-central1"
  type        = string
}

variable "zones" {
  description = "Deployment Zone(s); from ENV; E.G.: us-central1-a"
  type        = string
}

#variable "projectCreds" {
#  description = "Path to credentials file; from ENV; E.G.: ~/.config/gcloud/terraform.json"
#  type        = string
#}

variable "dns_name" {
  description = "Primary DNS name; E.G.: domain.tld"
  type        = string
}