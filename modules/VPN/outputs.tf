output "vpn_tunnel_name" {
  description = "Name of the VPN tunnel"
  value       = google_compute_vpn_tunnel.vpn_tunnel.name
}

output "vpn_gateway_name" {
  description = "Name of the VPN Gateway"
  value       = google_compute_vpn_gateway.vpn_gw.name
}

output "vpn_gateway_ip" {
  description = "Static external IP of the VPN Gateway"
  value       = google_compute_address.vpn_static_ip.address
}
