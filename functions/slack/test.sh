#!/bin/bash

IMAGE="truism-slack"

docker run -it --rm \
  -e GOOGLE_APPLICATION_CREDENTIALS="/creds/service_account.json" \
  -v "$(pwd)/../../etc:/creds" \
  -v "$(pwd):/workspace" \
  -w /workspace \
  "${IMAGE}"