#!/bin/sh

IMAGE="truisms-app"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
