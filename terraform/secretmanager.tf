resource "google_secret_manager_secret" "slack-client-id" {
  secret_id = "slack-client-id"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret" "slack-client-secret" {
  secret_id = "slack-client-secret"

  replication {
    automatic = true
  }
}
