/*
  --------------------------------------------------------|------------------------------------------------------------
                                                      TERRAFORM
  ---------------------------------------------------------------------------------------------------------------------
*/
# Check Releases here: version numbers tend to match, and should
# https://github.com/hashicorp/terraform-provider-google/releases
# https://github.com/hashicorp/terraform-provider-google-beta/releases
terraform {
  required_version = "~> 1.2.9"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.36.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.36.0"
    }
  }
}

/*
  --------------------------------------------------------|------------------------------------------------------------
                                                       PROJECT
  ---------------------------------------------------------------------------------------------------------------------
*/
provider "google" {
  #credentials = file(var.projectCreds)
  region = var.region
  #zone    = var.zone
  project = var.project_id
}

provider "google-beta" {
  #credentials = file(var.projectCreds)
  region = var.region
  #zone    = var.zone
  project = var.project_id
}

#TEST credentials file
#output "creds" {
#  value = var.projectCreds
#}
