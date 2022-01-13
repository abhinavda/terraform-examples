variable "machine_type_gcp" {
  default = "f1-micro"
}

variable "zone_given" {
  default = "us-central1-a"
}

variable "region_given" {
  default = "us-central1"
}

variable "http_port" {
  default = "80"
}

variable "https_port" {
  default = "443"
}

variable "svc_account" {
  default = "/Users/abhinavdamarapati/projects/git/new_projects/terraform-examples/ardent-dream-337620-ac612f7b334e.json"
}

variable "project_name" {
  default = "ardent-dream-337620"
}

variable "map1" {
  type = map(string)
  default = {
    us1="us1_val",
    us2="u2_val"
  }
}