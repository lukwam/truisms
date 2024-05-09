resource "google_project" "project" {
  name            = var.project_name
  project_id      = var.project_id
  folder_id       = var.folder_id
  billing_account = data.google_billing_account.default.id

  labels = {
    app      = "truisms",
    billing  = lower(data.google_billing_account.default.id),
    firebase = "enabled",
  }

  auto_create_network = false
  skip_delete         = false
}

resource "google_project_service" "services" {
  for_each = toset([
    "appengine.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudfunctions.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "firestore.googleapis.com",
    "secretmanager.googleapis.com",
  ])
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.project.project_id
}

resource "google_project_iam_member" "appengine" {
  for_each = toset([
    "roles/secretmanager.secretAccessor",
  ])
  project = google_project.project.project_id
  role    = each.key
  member  = "serviceAccount:${google_project.project.project_id}@appspot.gserviceaccount.com"
  depends_on = [
    google_project_service.services["appengine.googleapis.com"],
  ]
}

resource "google_project_iam_member" "cloudbuild" {
  for_each = toset([
    "roles/appengine.appAdmin",
    "roles/cloudfunctions.developer",
    "roles/cloudbuild.builds.builder",
    "roles/iam.serviceAccountUser",
    "roles/secretmanager.secretAccessor",
  ])
  project = google_project.project.project_id
  role    = each.key
  member  = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"],
  ]
}

resource "google_project_iam_member" "admin-lukwam-dev" {
  for_each = toset([
    "roles/secretmanager.secretAccessor",
  ])
  project = google_project.project.project_id
  role    = each.key
  member  = "user:admin@lukwam.dev"
}
