//resource "google_compute_network" "vpc_network" {
//  name = "vpc-network"
//  count=2
//}

//resource "google_compute_network" "vpc_network" {
//  name = "vpc-network-${count.index}"
//  count=2
//}

resource "google_compute_network" "vpc_network" {
  name = var.vpc-values[count.index]
  count=2
}