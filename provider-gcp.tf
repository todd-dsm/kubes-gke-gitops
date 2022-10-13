/*
  --------------------------------------------------------|------------------------------------------------------------
                                                      TERRAFORM
  ---------------------------------------------------------------------------------------------------------------------
*/
# Check google/google-beta Releases: version numbers tend to match, and should
terraform {
  required_version = "~> 1.3.0"
  required_providers {
    # https://github.com/hashicorp/terraform-provider-google/releases
    google = {
      source  = "hashicorp/google"
      version = ">= 4.3.0, < 5.0.0"
    }
    # https://github.com/hashicorp/terraform-provider-google-beta/releases
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.3.0, < 5.0.0"
    }
    # https://registry.terraform.io/providers/hashicorp/kubernetes/latest
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
}

/*
  --------------------------------------------------------|------------------------------------------------------------
                                                   PROJECT CONFIG
  ---------------------------------------------------------------------------------------------------------------------
*/
provider "google" {
  region  = var.region
  project = var.project_id
}

provider "google-beta" {
  region  = var.region
  project = var.project_id
}

