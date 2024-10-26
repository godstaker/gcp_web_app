variable "gcs_tf_bucket" {
  description = "The GCS bucket used for Terraform state"
  type        = string
}

variable "project_id" {
  type        = string
  description = "The Google Cloud Project ID"
}