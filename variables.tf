variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
}

variable "gke_options" {
  description = "Configuration for the GKE cluster"
  type = object({
    cluster_name            = string
    enable_private_nodes    = bool
    enable_private_endpoint = bool
    master_ipv4_cidr_block  = string
  })
}

variable "network_options" {
  description = "Network configuration"
  type = object({
    vpc_name      = string
    subnet_name   = string
    subnet_cidr   = string
    pods_cidr     = string
    services_cidr = string
  })
}

# variable "jumpbox_options" {
#   description = "Jumpbox VM configuration"
#   type = object({
#     jumpbox_name           = string
#     jumpbox_machine_type   = string
#     jumpbox_image          = string
#     jumpbox_startup_script = string
#     jumpbox_tags           = list(string)
#   })
# }

variable "firewall_options" {
  description = "Firewall rules configuration"
  type = object({
    firewall_name          = string
    firewall_ports         = list(string)
    firewall_source_ranges = list(string)
    firewall_target_tags   = list(string)
  })
}

variable "service_account_roles" {
  description = "List of IAM roles for the jumpbox service account"
  type        = list(string)
}


variable "vpn_shared_secret" {
  description = "Shared secret for the VPN tunnel"
  type        = string
  sensitive   = true
}

variable "local_gateway_ip" {
  description = "Your local public IP address"
  type        = string
}

variable "local_cidr_range" {
  description = "Your local network's CIDR range"
  type        = string
  default     = "192.168.100.0/24"
}
