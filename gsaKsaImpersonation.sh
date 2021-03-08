#!/bin/bash

export PROJECT_ID=dealwire-dev-studio-001
export K8S_NAMESPACE=default
export KSA_NAME=notifications-ksa
export GSA_NAME=notifications

if [[ $1 == "bind" ]]; then
  # BIND THE KSA SERVICE ACCOUNT TO THE GCP SERVICE ACCOUNT
  gcloud iam service-accounts add-iam-policy-binding \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:${PROJECT_ID}.svc.id.goog[${K8S_NAMESPACE}/${KSA_NAME}]" ${GSA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com
elif [[ $1 == "annotate" ]]; then
  # ANNOTATE THE KSA WITH GCP SERVICE ACCOUNT
  kubectl annotate serviceaccount --namespace ${KSA_NAMESPACE} ${KSA_NAME} "iam.gke.io/gcp-service-account=${GSA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
else
  echo "Error: Unidentified Command $1"
fi
