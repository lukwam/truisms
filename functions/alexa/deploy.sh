#!/usr/bin/env bash

(
    cd ../../ && gcloud builds submit \
        --config functions/alexa/cloudbuild.yaml \
        --project lukwam-truisms
)