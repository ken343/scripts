#!/bin/bash
set -x

export NODEPOOL_NAME=development-workload
export CLUSTER_NAME=my-cluster
export MACHINE_TYPE=
export NODE_COUNT=4

# Create New Node-Pool
gcloud container node-pools create ${NODEPOOL_NAME} \
  --cluster=${CLUSTER_NAME} \
  --workload-metadata=GKE_METADATA

# Update Existing Node-Pool
gcloud container node-pools update ${NODEPOOL_NAME} \
  --cluster=${CLUSTER_NAME} \
  --workload-metadata=GKE_METADATA \
  --machine-type=${MACHINE_TYPE} --num-nodes=${NODE_COUNT}

