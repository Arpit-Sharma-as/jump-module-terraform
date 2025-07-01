output "gke_cluster_name" {
  value = module.gke.gke_cluster_name
}

output "gke_cluster_endpoint" {
  value = module.gke.gke_cluster_endpoint
}

output "gke_cluster_master_version" {
  value = module.gke.gke_cluster_master_version
}

# output "jumpbox_public_ip" {
#   value = module.jumpbox.jumpbox_public_ip
# }

output "vpn_gateway_ip" {
  value       = module.vpn.vpn_gateway_ip
  description = "Public IP of the GCP VPN Gateway for client configuration"
}
