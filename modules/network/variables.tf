variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "pods_cidr" {
  type        = string
  description = "CIDR block for pods"
}

variable "services_cidr" {
  type        = string
  description = "CIDR block for services"
}

variable "region" {
  type        = string
  description = "Region for the network"
}

variable "depends_on_apis" {
  description = "Dependency to wait until APIs are enabled"
}
