resource "google_compute_network" "this" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr_range
  region        = var.region
  network       = google_compute_network.this.self_link
}

resource "google_container_cluster" "this" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = var.node_count

  network    = google_compute_network.this.id
  subnetwork = google_compute_subnetwork.this.id

  node_config {
    machine_type = var.machine_type
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }
}