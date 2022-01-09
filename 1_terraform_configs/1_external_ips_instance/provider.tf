terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.5.0"
    }
  }
}

provider "google" {
  credentials = file("../../ardent-dream-337620-ac612f7b334e.json")

  project = "ardent-dream-337620"
  region = "us-central1"
  zone = "us-central1-c"
}