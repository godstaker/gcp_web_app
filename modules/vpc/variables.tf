variable "vpc_network_name" {
  description = "vpc network name"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "vpc network name"
  type        = bool
  value       = false
}
variable "routing_mode" {
  description = "vpc network name"
  type        = string
  value       = "REGIONAL"
}
variable "delete_default_routes_on_create" {
  description = "delete default routes"
  type        = bool
  value        = true
}