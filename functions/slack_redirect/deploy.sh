#!/usr/bin/env bash

(
    cd ../../ && gcloud builds submit \
        --config functions/slack_redirect/cloudbuild.yaml \
        --project lukwam-truisms
)