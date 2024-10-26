# Retrieve client configuration, including access token
data "google_client_config" "default" {}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Create the GKE Cluster
resource "google_container_cluster" "this" {
  name                     = var.cluster_name
  location                 = var.region
  network                  = var.network_name
  subnetwork               = var.subnet_name
  remove_default_node_pool = true
  initial_node_count       = 1

  # Kubernetes cluster settings
  node_config {
    machine_type = var.node_machine_type
  }

  # Optional: Enable GKE features
  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

# Create the Node Pool
resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.this.name
  location   = var.region
  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# Configure the Kubernetes provider to interact with the GKE cluster
provider "kubernetes" {
  host                   = google_container_cluster.this.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.this.master_auth[0].cluster_ca_certificate)
}

# Create dev and prod namespaces
resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
  }
}