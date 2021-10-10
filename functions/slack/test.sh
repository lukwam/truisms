#!/bin/bash

IMAGE="truism-slack"
GCP_PROJECT="lukwam-truisms"

docker run -it --rm \
  -e GCP_PROJECT="${GCP_PROJECT}" \
  -e GOOGLE_APPLICATION_CREDENTIALS="/creds/service_account.json" \
  -v "$(pwd)/../../etc:/creds" \
  -v "$(pwd):/workspace" \
  -w /workspace \
  "${IMAGE}"
