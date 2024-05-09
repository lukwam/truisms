#!/usr/bin/env bash

(
    cd ../../ && gcloud builds submit \
        --config functions/assistant/cloudbuild.yaml \
        --project lukwam-truisms
)