#!/bin/sh

IMAGE="truism-alexa"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
