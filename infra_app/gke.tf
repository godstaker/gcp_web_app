# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}
module "gke" {
  source                   = "squareops/kubernetes-engine/google"
  project                  = var.project_id
  name                     = "webapp"
  region                   = "europe-west2"
  environment              = "dev"
  gke_zones                = ["europe-west2-a", "europe-west2-b"]
  vpc_name                 = "gke-vpc"
  subnet                   = "dev-subnet-1"
  kubernetes_version       = "1.25"
  default_np_instance_type = "e2-medium"
  default_np_max_count     = 2
  default_np_preemptible   = true

}


module "node_pool" {
  source             = "squareops/kubernetes-engine/google//modules/node-pool"
  depends_on         = [module.gke]
  project            = project_name
  name               = module.gke.name
  environment        = "dev"
  location           = "europe-west2"
  kubernetes_version = "1.25"
  service_account    = module.gke.service_accounts_gke
  initial_node_count = 1
  min_count          = 1
  max_count          = 2
  node_locations     = ["europe-west2-a", "europe-west2-b"]
  preemptible        = true
  instance_type      = "e2-medium"
  disk_size_gb       = 50
  labels = {
    "App-services" : true
  }
}
