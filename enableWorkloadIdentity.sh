#!/bin/sh
set -x
export CLUSTER_NAME=my-cluster
export PROJECT_ID=dealwire-dev-studio-001

gcloud container clusters update ${CLUSTER_NAME} --workload-pool=${PROJECT_ID}.svc.id.goog
