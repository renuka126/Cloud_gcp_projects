#!/bin/bash

# Description: IAM and permissions management for GCS buckets

# Replace with your actual values
BUCKET_NAME="your-bucket-name"
EMAIL="your-email@gmail.com"
PROJECT_ID="your-project-id"

# View current IAM policy of a bucket
gsutil iam get gs://BUCKET_NAME

# Grant a user read access to a bucket
gsutil iam ch user:EMAIL@gmail.com:objectViewer gs://BUCKET_NAME

# Grant a user write access to a bucket
gsutil iam ch user:EMAIL@gmail.com:objectCreator gs://BUCKET_NAME

# Grant a user full control (admin)
gsutil iam ch user:EMAIL@gmail.com:admin gs://BUCKET_NAME

# Remove a user's access from bucket
gsutil iam ch -d user:EMAIL@gmail.com gs://BUCKET_NAME

# Make bucket publicly readable (anyone can view)
gsutil iam ch allUsers:objectViewer gs://BUCKET_NAME

# Remove public access
gsutil iam ch -d allUsers:objectViewer gs://BUCKET_NAME

# Grant service account access
gsutil iam ch serviceAccount:SA_NAME@PROJECT_ID.iam.gserviceaccount.com:objectViewer gs://BUCKET_NAME