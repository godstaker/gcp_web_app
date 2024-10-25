output "cluster_endpoint" {
  value       = google_container_cluster.this.endpoint
  description = "Endpoint of the GKE cluster"
}

output "cluster_name" {
  value       = google_container_cluster.this.name
  description = "Name of the GKE cluster"
}