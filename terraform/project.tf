resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  folder_id       = var.folder_id
  billing_account = data.google_billing_account.default.id

  labels = {
    app           = "truisms"
    billing       = lower(data.google_billing_account.default.id),
  }

  auto_create_network = false
  skip_delete         = false
}


resource "google_project_service" "services" {
  for_each = toset([
    "appengine.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
  ])
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.project.project_id
}

resource "google_project_iam_member" "cloudbuild" {
  for_each = toset([
    "roles/appengine.appAdmin",
    "roles/cloudfunctions.developer",
    "roles/cloudbuild.builds.builder",
    "roles/iam.serviceAccountUser",
  ])
  project = google_project.project.project_id
  role    = each.key
  member  = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"],
  ]
}
