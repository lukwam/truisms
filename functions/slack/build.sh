#!/bin/sh

IMAGE="truism-slack"

pack build "${IMAGE}" --builder gcr.io/buildpacks/builder:v1
