terraform {
  required_version = ">= 1.0.0"  # Replace with your required version

  backend "gcs" {
    bucket = "av-webapp282265" # Replace with your GCS bucket name
    prefix = "terraform/state"  # Folder path within the bucket to store the state
  }
}
