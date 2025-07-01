resource "google_compute_vpn_gateway" "vpn_gw" {
  name    = "gke-vpn-gateway"
  network = var.vpc_self_link
  region  = var.region
}

resource "google_compute_address" "vpn_static_ip" {
  name   = "vpn-static-ip"
  region = var.region
}

resource "google_compute_vpn_tunnel" "vpn_tunnel" {
  name                    = "gke-vpn-tunnel"
  region                  = var.region
  target_vpn_gateway      = google_compute_vpn_gateway.vpn_gw.id
  peer_ip                 = var.local_gateway_ip
  shared_secret           = var.vpn_shared_secret
  ike_version             = 2

  local_traffic_selector = [var.subnet_cidr]
  remote_traffic_selector = [var.local_cidr_range]

  depends_on = [
    google_compute_forwarding_rule.vpn_esp_rule,
    google_compute_forwarding_rule.vpn_udp_500_rule,
    google_compute_forwarding_rule.vpn_udp_4500_rule
  ]
}

resource "google_compute_route" "vpn_route" {
  name             = "route-to-local"
  network          = var.vpc_self_link
  dest_range       = var.local_cidr_range
  priority         = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.vpn_tunnel.id
  depends_on       = [google_compute_vpn_tunnel.vpn_tunnel]
}

resource "google_compute_forwarding_rule" "vpn_esp_rule" {
  name        = "vpn-esp-rule"
  region      = var.region
  ip_protocol = "ESP"
  ip_address = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.vpn_gw.id
}

resource "google_compute_forwarding_rule" "vpn_udp_500_rule" {
  name        = "vpn-udp500-rule"
  region      = var.region
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.vpn_gw.id
}

resource "google_compute_forwarding_rule" "vpn_udp_4500_rule" {
  name        = "vpn-udp4500-rule"
  region      = var.region
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.vpn_gw.id
}
