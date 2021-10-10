#!/bin/sh

IMAGE="truism"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
