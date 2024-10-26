resource "google_compute_network" "this" {
  name                            = var.vpc_network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_subnetwork" "this" {
  count                    = length(var.subnets)
  name                     = var.subnets[count.index].name
  ip_cidr_range            = var.subnets[count.index].ip_cidr_range
  region                   = var.subnets[count.index].region
  network                  = google_compute_network.this.self_link
  private_ip_google_access = var.subnets[count.index].private_ip_google_access
}