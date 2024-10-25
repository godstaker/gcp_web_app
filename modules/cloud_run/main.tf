resource "google_cloud_run_service" "this" {
  name     = var.cloudrun_app_name
  location = var.location

  template {
    spec {
      containers {
        image = var.container_image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}