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
    us1 = "us1_val",
    us2 = "us2_val"
  }
}

variable "vpc-values" {
  type    = list(any)
  default = ["vpc-prod", "vpc-staging", "vpc-dev"]
}

// Conditional Expressions
variable "is_this_prod" {}


// Using data source
data "google_project" "project" {
}

output "project_number" {
  value = data.google_project.project.number
}

output "project_number_values" {
  value = data.google_project.project
}

// dynamic block
variable "firewall_ports" {
  type        = list(string)
  description = "list of ports"
  default     = ["80", "8080", "1000-2000"]
}