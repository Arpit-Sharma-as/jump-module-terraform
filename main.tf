provider "google" {
  project = var.project_id
  region  = var.region
}

module "enable_apis" {
  source     = "./modules/enable_apis"
  project_id = var.project_id
}

module "network" {
  source          = "./modules/network"
  region          = var.region
  vpc_name        = var.network_options.vpc_name
  subnet_name     = var.network_options.subnet_name
  subnet_cidr     = var.network_options.subnet_cidr
  pods_cidr       = var.network_options.pods_cidr
  services_cidr   = var.network_options.services_cidr
  depends_on_apis = module.enable_apis
}

module "gke" {
  source                  = "./modules/gke"
  region                  = var.region
  cluster_name            = var.gke_options.cluster_name
  master_ipv4_cidr_block  = var.gke_options.master_ipv4_cidr_block
  enable_private_nodes    = var.gke_options.enable_private_nodes
  enable_private_endpoint = var.gke_options.enable_private_endpoint
  vpc_name                = module.network.vpc_name
  subnet_name             = module.network.subnet_name
  master_authorized_cidr  = var.local_cidr_range
  depends_on_network      = true
}





# module "jumpbox" {
#   source                    = "./modules/jumpbox"
#   region                    = var.region
#   project_id                = var.project_id            
#   jumpbox_options           = var.jumpbox_options
#   firewall_options          = var.firewall_options
#   service_account_roles     = var.service_account_roles
#   vpc_self_link             = module.network.vpc_self_link
#   subnet_self_link          = module.network.subnet_self_link
#   depends_on                = [module.network]
# }

module "vpn" {
  source            = "./modules/vpn"
  project_id        = var.project_id
  region            = var.region
  vpc_self_link     = module.network.vpc_self_link
  # subnet_cidr       = var.network_options.subnet_cidr # ✅ this is now valid
  vpn_shared_secret = var.vpn_shared_secret
  local_gateway_ip  = var.local_gateway_ip
  local_cidr_range  = var.local_cidr_range
  subnet_cidr       = var.network_options.subnet_cidr
}
