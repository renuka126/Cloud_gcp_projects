#!/bin/bash

# List all Cloud Storage buckets
gcloud storage buckets list

# Create a new bucket
gcloud storage buckets create gs://my-storage-bucket \
    --location=us-central1

# Upload a file to the bucket
gcloud storage cp sample.txt gs://my-storage-bucket/

# List files in the bucket
gcloud storage ls gs://my-storage-bucket/

# Download a file from the bucket
gcloud storage cp gs://my-storage-bucket/sample.txt .

# Copy a file within Cloud Storage
gcloud storage cp gs://my-storage-bucket/sample.txt \
    gs://my-storage-bucket/backup-sample.txt

# Delete a file from the bucket
gcloud storage rm gs://my-storage-bucket/sample.txt

# Delete the bucket
gcloud storage buckets delete gs://my-storage-bucket --quiet