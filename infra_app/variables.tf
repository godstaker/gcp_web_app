variable "gcs_tf_bucket" {
  description = "The GCS bucket used for Terraform state"
  type        = string
}

variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}

variable "region" {
  type        = string
  description = "The GCP region to deploy the cluster to"
  default     = "europe-west2"
}

variable "machine_type" {
  type        = string
  description = "The machine type for the cluster nodes"
  default     = "e2-medium"
}

variable "node_machine_type" {
  description = "Machine type for nodes in the default node pool"
  type        = string
  default     = "e2-medium"
}