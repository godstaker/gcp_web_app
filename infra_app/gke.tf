module "gke_cluster" {
  source                        = "../modules/gke"
  project_id                    = var.project_id
  region                        = var.region
  cluster_name                  = "contoso"
  network_name                  = "gke-cluster"
  subnet_name                   = "webapp"
  node_machine_type             = var.node_machine_type
  node_count                    = 1
  services_ipv4_cidr_block      = "10.0.0.0/26"
  services_secondary_range_name = "services-secondary-range"
  machine_type                  = var.machine_type
  subnet_cidr_range             = "10.0.1.0/26"
  cluster_ipv4_cidr_block       = "10.0.2.0/26"
  cluster_secondary_range_name  = "cluster-secondary-range"
}
