variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}

variable "region" {
  type        = string
  description = "The GCP region to deploy the cluster to"
}

variable "cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "node_count" {
  type        = number
  description = "The number of nodes in the cluster"
}

variable "machine_type" {
  type        = string
  description = "The machine type for the cluster nodes"
}

variable "node_machine_type" {
  description = "Machine type for nodes in the default node pool"
  type        = string
  default     = "e2-medium"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "subnet_cidr_range" {
  type        = string
  description = "The CIDR range for the subnet"
}

variable "cluster_ipv4_cidr_block" {
  type        = string
  description = "The IP address range for the cluster"
}

variable "services_ipv4_cidr_block" {
  type        = string
  description = "The IP address range for the services"
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "The name of the secondary range for the cluster"
}

variable "services_secondary_range_name" {
  type        = string
  description = "The name of the secondary range for the services"
}