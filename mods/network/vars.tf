/*
  --------------------------------------------------------|-------------------------------------------------------------
                                                      NETWORKING
  ----------------------------------------------------------------------------------------------------------------------
*/

variable "project_id" {
  description = "Currently configured project ID; from ENV; E.G.: My First Project"
  type        = string
}

variable "region" {
  description = "Deployment Region; from ENV; E.G.: us-central1"
  type        = string
}

variable "min_dist_size" {
  description = "Minimum distribution size; I.E.: integer >/= 3"
  type        = number
}

variable "cidr_range" {
  description = "CIDR size/range of the target network"
  type        = string
}