// Create external static ip and associate it with an instance
resource "google_compute_address" "static" {
  name = "ipv4-address"
}
output "static_ip" {
  value = google_compute_address.static.address
}
// End - external static ip and associate it with an instance

// start - creating an instance
data "google_compute_image" "debian_image" {
  family  = "debian-9"
  project = "debian-cloud"
}
resource "google_compute_instance" "instance_with_ip" {
  name         = "vm-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}
// end - creating an instance

// Creating a staging group
resource "google_compute_instance_group" "staging_group" {
  name      = "staging-instance-group"
  zone      = "us-central1-a"
  instances = [google_compute_instance.instance_with_ip.id]
  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "8443"
  }

  lifecycle {
    create_before_destroy = true
  }
}
// end - creation of staging group

// start compute health
resource "google_compute_https_health_check" "staging_health" {
  name         = "staging-health"
  request_path = "/health_check"
}
//end - compute health

// start - staging backend service
resource "google_compute_backend_service" "staging_service" {
  name      = "staging-service"
  port_name = "https"
  protocol  = "HTTPS"

  backend {
    group = google_compute_instance_group.staging_group.id
  }

  health_checks = [
    google_compute_https_health_check.staging_health.id,
  ]
}
// end - staging backend service
