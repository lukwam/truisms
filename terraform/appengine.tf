resource "google_app_engine_application" "app" {
  project       = google_project.project.project_id
  location_id   = var.region
  database_type = "CLOUD_FIRESTORE"
  depends_on = [
    google_project_service.services["appengine.googleapis.com"]
  ]
}

resource "google_app_engine_domain_mapping" "domain_mapping" {
  domain_name = var.domain_name
  project     = google_project.project.project_id

  ssl_settings {
    ssl_management_type = "AUTOMATIC"
  }

  depends_on = [
    google_project_service.services["appengine.googleapis.com"]
  ]
}