#!/bin/bash

IMAGE="truisms-app"

docker run -it --rm \
  --expose 8080 \
  -e GOOGLE_APPLICATION_CREDENTIALS="/creds/service_account.json" \
  -p 8080:8080 \
  -v "$(pwd)/../etc:/creds" \
  -v "$(pwd):/workspace" \
  -w /workspace \
  "${IMAGE}"
