variable "cloudrun_app_name" {
  description = "(Required) Name must be unique within a Google Cloud project and region. Is required when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated"
  type        = string
}

variable "location" {
  description = " (Required) The location of the cloud run instance. eg europe-west2"
  type        = string
  default     = "europe-west2"
}

variable "container_image" {
  description = ""
  type        = string
}

variable "project_id" {
  description = "project_id"
  type        = string
}

variable "region" {
  description = "region eg: europe-west2"
  type        = string
  default     = "europe-west2"
}