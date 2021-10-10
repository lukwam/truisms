#!/bin/sh

IMAGE="truism-assistant"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
