#!/bin/bash
IMAGE="truism-slack-redirect"
GCP_PROJECT="lukwam-truisms"

SLACK_CLIENT_ID=$(gcloud secrets versions access latest --secret slack-client-id)
SLACK_CLIENT_SECRET=$(gcloud secrets versions access latest --secret slack-client-secret)

docker run -it --rm \
  -e GCP_PROJECT="${GCP_PROJECT}" \
  -e GOOGLE_APPLICATION_CREDENTIALS="/creds/service_account.json" \
  -e SLACK_CLIENT_ID="${SLACK_CLIENT_ID}" \
  -e SLACK_CLIENT_SECRET="${SLACK_CLIENT_SECRET}" \
  -v "$(pwd)/../../etc:/creds" \
  -v "$(pwd):/workspace" \
  -w /workspace \
  "${IMAGE}"
