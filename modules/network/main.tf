resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods-subnet"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "services-subnet"
    ip_cidr_range = var.services_cidr
  }
}

resource "google_compute_firewall" "allow_vpn_to_master" {
  name    = "allow-vpn-to-master"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["192.168.100.0/24"]
  direction     = "INGRESS"
  priority      = 1000
}
