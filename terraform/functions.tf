data "google_cloudfunctions_function" "alexa" {
  name = "alexa"
}
data "google_cloudfunctions_function" "assistant" {
  name = "assistant"
}
data "google_cloudfunctions_function" "slack" {
  name = "slack"
}
data "google_cloudfunctions_function" "slack_redirect" {
  name = "slack_redirect"
}
data "google_cloudfunctions_function" "truism" {
  name = "truism"
}
data "google_cloudfunctions_function" "update" {
  name = "update"
}

resource "google_cloudfunctions_function_iam_member" "alexa_allusers" {
  project = data.google_cloudfunctions_function.alexa.project
  region = data.google_cloudfunctions_function.alexa.region
  cloud_function = data.google_cloudfunctions_function.alexa.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "assistant_allusers" {
  project = data.google_cloudfunctions_function.assistant.project
  region = data.google_cloudfunctions_function.assistant.region
  cloud_function = data.google_cloudfunctions_function.assistant.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "slack_allusers" {
  project = data.google_cloudfunctions_function.slack.project
  region = data.google_cloudfunctions_function.slack.region
  cloud_function = data.google_cloudfunctions_function.slack.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "slack_redirect_allusers" {
  project = data.google_cloudfunctions_function.slack_redirect.project
  region = data.google_cloudfunctions_function.slack_redirect.region
  cloud_function = data.google_cloudfunctions_function.slack_redirect.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "truism_allusers" {
  project = data.google_cloudfunctions_function.truism.project
  region = data.google_cloudfunctions_function.truism.region
  cloud_function = data.google_cloudfunctions_function.truism.name
  role = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
