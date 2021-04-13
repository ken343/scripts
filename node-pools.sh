#!/bin/bash

export NODEPOOL_NAME=development-workload
export CLUSTER_NAME=my-cluster
export MACHINE_TYPE=n1-standard-1
export NODE_COUNT=6

echo $1
echo $0
echo $2

if [[ $1 == "create" ]]; then
	# Create New Node-Pool
	gcloud container node-pools create ${NODEPOOL_NAME} \
	  --cluster=${CLUSTER_NAME} \
	  --workload-metadata=GKE_METADATA
	  --machine-type=${MACHINE_TYPE} \
	  --num-nodes=${NODE_COUNT}
elif [[ $1 == "update" ]]; then
	# Update Existing Node-Pool
	gcloud container node-pools update ${NODEPOOL_NAME} \
	  --cluster=${CLUSTER_NAME} \
	  --workload-metadata=GKE_METADATA \
	  --machine-type=${MACHINE_TYPE} \
	  --num-nodes=${NODE_COUNT}
else
	echo "You must choose to create or update the pools"
fi
