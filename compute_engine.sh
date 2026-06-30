#!/bin/bash

# Set variables
PROJECT_ID="your-project-id"
ZONE="us-central1-a"
REGION="us-central1"
INSTANCE_NAME="my-vm"

# Set project
gcloud config set project $PROJECT_ID

# List Compute Engine instances
gcloud compute instances list

# Create a VM instance
gcloud compute instances create $INSTANCE_NAME \
    --zone=$ZONE \
    --machine-type=e2-micro \
    --image-family=debian-12 \
    --image-project=debian-cloud

# Describe the VM
gcloud compute instances describe $INSTANCE_NAME --zone=$ZONE

# Start the VM
gcloud compute instances start $INSTANCE_NAME --zone=$ZONE

# Stop the VM
gcloud compute instances stop $INSTANCE_NAME --zone=$ZONE

# Restart the VM
gcloud compute instances reset $INSTANCE_NAME --zone=$ZONE

# SSH into the VM
gcloud compute ssh $INSTANCE_NAME --zone=$ZONE

# Create a snapshot of a disk
gcloud compute disks snapshot $INSTANCE_NAME \
    --snapshot-names=${INSTANCE_NAME}-snapshot \
    --zone=$ZONE

# Delete the VM
gcloud compute instances delete $INSTANCE_NAME --zone=$ZONE --quiet