#!/usr/bin/env bash

(
    cd ../../ && gcloud builds submit \
        --config functions/truism/cloudbuild.yaml \
        --project lukwam-truisms
)