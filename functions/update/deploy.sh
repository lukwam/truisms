#!/usr/bin/env bash

(
    cd ../../ && gcloud builds submit \
        --config functions/update/cloudbuild.yaml \
        --project lukwam-truisms \
        --substitutions _TRUISMS_BUCKET=lukwam-truisms
)