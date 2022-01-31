//
// Count and Count indices //
//

//resource "google_compute_network" "vpc_network" {
//  name = "vpc-network"
//  count=2
//}

//resource "google_compute_network" "vpc_network" {
//  name = "vpc-network-${count.index}"
//  count=2
//}

//resource "google_compute_network" "vpc_network" {
//  name = var.vpc-values[count.index]
//  count=2
//}

//
// Conditional Expressions //
//

//resource "google_compute_network" "vpc_network_prod" {
//  name = "vpc-prod"
//  count=var.is_this_prod==true ? 1:0
//}
//
//resource "google_compute_network" "vpc_network_dev" {
//  name = "vpc-dev"
//  count=var.is_this_prod==false ? 1:0
//}

//
// locals //
//

// this section is not working
//locals {
//  common_tags= {
//    owner="Abhinav"
//    service="backend"
//  }
//}
//

locals {
  common_tags = [
    "Abhinav", "backend"
  ]
}


//resource "google_compute_network" "vpc_network_prod" {
//  name = "vpc-prod"
//  count=var.is_this_prod==true ? 1:0
//  tags=local.common_tags
//}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = local.common_tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }
}

//dynamic block with ingress

//before applying dynamic block
//resource "google_compute_firewall" "default" {
//  name    = "test-firewall"
//  network = google_compute_network.default.name
//
//  allow {
//    protocol = "icmp"
//  }
//
//  allow {
//    protocol = "tcp"
//    ports    = ["80", "8080", "1000-2000"]
//  }
//
//  source_tags = ["web"]
//}
//
//resource "google_compute_network" "default" {
//  name = "test-network"
//}

//after applying dynamic block
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }


  allow {
    dynamic "ports" {
      for_each = var.firewall_ports

      content {

        ports     = ports.value

      }
    }
    protocol = "tcp"
  }

  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "test-network"
}