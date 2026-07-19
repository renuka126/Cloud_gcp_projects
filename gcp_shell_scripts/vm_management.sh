#!/bin/bash

# Start a VM instance
gcloud compute instances start my-vm --zone=us-central1-a

# Stop a VM instance
gcloud compute instances stop my-vm --zone=us-central1-a

# Restart a VM instance
gcloud compute instances reset my-vm --zone=us-central1-a

# Delete a VM instance
gcloud compute instances delete my-vm --zone=us-central1-a --quiet