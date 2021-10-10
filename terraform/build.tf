resource "google_cloudbuild_trigger" "deploy-app" {
  provider       = google-beta
  name           = "deploy-app"
  description    = "Deploy App"
  filename       = "app/cloudbuild.yaml"
  project        = google_project.project.project_id
  included_files = [
    "app/**",
  ]
  ignored_files = [
    "app/*.md",
    "app/*.sh",
  ]

  github {
    name     = var.repo
    owner    = var.github_login
    push {
      branch = var.branch
    }
  }

  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"]
  ]
}

resource "google_cloudbuild_trigger" "deploy-update-function" {
  provider       = google-beta
  name           = "deploy-update-function"
  description    = "Deploy Update Function"
  filename       = "functions/update/cloudbuild.yaml"
  project        = google_project.project.project_id
  included_files = [
    "functions/update/**",
  ]
  ignored_files = [
    "functions/update/*.md",
    "functions/update/*.sh",
  ]

  github {
    name     = var.repo
    owner    = var.github_login
    push {
      branch = var.branch
    }
  }

  substitutions = {
    _TRUISMS_BUCKET = google_storage_bucket.truisms.name
  }

  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"]
  ]
}

resource "google_cloudbuild_trigger" "deploy-slack-function" {
  provider       = google-beta
  name           = "deploy-slack-function"
  description    = "Deploy Slack Function"
  filename       = "functions/slack/cloudbuild.yaml"
  project        = google_project.project.project_id
  included_files = [
    "functions/slack/**",
  ]
  ignored_files = [
    "functions/slack/*.md",
    "functions/slack/*.sh",
  ]

  github {
    name     = var.repo
    owner    = var.github_login
    push {
      branch = var.branch
    }
  }

  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"]
  ]
}

resource "google_cloudbuild_trigger" "deploy-slack-redirect-function" {
  provider       = google-beta
  name           = "deploy-slack-redirect-function"
  description    = "Deploy Slack Redirect Function"
  filename       = "functions/slack_redirect/cloudbuild.yaml"
  project        = google_project.project.project_id
  included_files = [
    "functions/slack_redirect/**",
  ]
  ignored_files = [
    "functions/slack_redirect/*.md",
    "functions/slack_redirect/*.sh",
  ]

  github {
    name     = var.repo
    owner    = var.github_login
    push {
      branch = var.branch
    }
  }

  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"]
  ]
}

resource "google_cloudbuild_trigger" "deploy-truism-function" {
  provider       = google-beta
  name           = "deploy-truism-function"
  description    = "Deploy Truism Function"
  filename       = "functions/truism/cloudbuild.yaml"
  project        = google_project.project.project_id
  included_files = [
    "functions/truism/**",
  ]
  ignored_files = [
    "functions/truism/*.md",
    "functions/truism/*.sh",
  ]

  github {
    name     = var.repo
    owner    = var.github_login
    push {
      branch = var.branch
    }
  }

  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"]
  ]
}

resource "google_cloudbuild_trigger" "update-truisms" {
  provider       = google-beta
  name           = "update-truisms"
  description    = "Update Truisms"
  project        = google_project.project.project_id
  included_files = [
    "truisms.txt",
  ]

  build {
    step {
      name = "gcr.io/cloud-builders/gsutil"
      args = ["cp", "truisms.txt", "gs://${google_storage_bucket.truisms.name}/truisms.txt"]
      timeout = "30s"
    }
  }

  github {
    name     = var.repo
    owner    = var.github_login
    push {
      branch = var.branch
    }
  }

  depends_on = [
    google_project_service.services["cloudbuild.googleapis.com"]
  ]
}
