#!/usr/bin/env bash

(
    cd ../../ && gcloud builds submit \
        --config functions/slack/cloudbuild.yaml \
        --project lukwam-truisms
)