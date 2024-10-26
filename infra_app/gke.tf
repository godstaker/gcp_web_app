module "gke_cluster" {
  source            = "../modules/gke"
  project_id        = var.project_id
  region            = var.region
  cluster_name      = "contoso"
  network_name      = "gke-cluster"
  subnet_name       = "webapp"
  node_machine_type = var.node_machine_type
  node_count        = 1
}
