terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.svc_account)
  project     = var.project_name
  region      = var.region_given
  zone        = var.zone_given
}