variable "vpc_network_name" {
  description = "vpc network name"
  type        = string
}

variable "auto_create_subnetworks" {
  description = "vpc network name"
  type        = bool
  default     = false
}
variable "routing_mode" {
  description = "vpc network name"
  type        = string
  default     = "REGIONAL"
}
variable "delete_default_routes_on_create" {
  description = "delete default routes"
  type        = bool
  default     = true
}

variable "subnets" {
  description = "A list of subnet configurations. Each subnet requires a name, CIDR block, and region."
  type = list(object({
    name                     = string
    ip_cidr_range            = string
    region                   = string
    private_ip_google_access = bool
  }))
}