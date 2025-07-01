resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  initial_node_count     = 1
  deletion_protection    = false
  network                = var.vpc_name
  subnetwork             = var.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-subnet"
    services_secondary_range_name = "services-subnet"
  }

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

#   master_authorized_networks_config {
#   cidr_blocks {
#     cidr_block   = "10.0.0.0/16" 
#     display_name = "internal-network"
#   }
# }

master_authorized_networks_config {
  cidr_blocks {
    cidr_block   = var.master_authorized_cidr
    display_name = "VPN"
  }
}



  default_max_pods_per_node = 110

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = false
    }
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  depends_on = [var.depends_on_network]
  
}
