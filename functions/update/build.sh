#!/bin/sh

IMAGE="update-truisms"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
