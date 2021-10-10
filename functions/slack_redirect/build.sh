#!/bin/sh

IMAGE="truism-slack-redirect"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
