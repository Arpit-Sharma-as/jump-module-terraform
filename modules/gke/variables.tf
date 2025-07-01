variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "region" {
  type        = string
  description = "Region for the GKE cluster"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "subnet_name" {
  type        = string
  description = "Subnetwork name"
}

variable "enable_private_nodes" {
  type        = bool
  description = "Whether to enable private nodes"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "Whether to enable private endpoint"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "CIDR block for master access"
}

variable "master_authorized_cidr" {
  type        = string
  description = "CIDR block allowed to access the master"
}

variable "depends_on_network" {
  description = "Dependency to wait for network setup"
}
