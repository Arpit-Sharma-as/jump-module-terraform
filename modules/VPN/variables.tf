variable "project_id" {}
variable "region" {}
variable "vpc_self_link" {}
variable "vpn_shared_secret" {}
variable "local_gateway_ip" {}
variable "local_cidr_range" {}
variable "subnet_cidr" {
  type = string
}