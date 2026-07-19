#!/bin/bash

# Replace BUCKET_NAME with your actual bucket name before running
BUCKET_NAME="your-bucket-name"

# List objects inside a bucket
gsutil ls gs://BUCKET_NAME/

# Copy file from bucket to local
gsutil cp gs://BUCKET_NAME/file.txt ./

# Copy entire folder to bucket (recursive)
gsutil cp -r ./local_folder gs://BUCKET_NAME/

# Move/rename object in bucket
gsutil mv gs://BUCKET_NAME/old_name.txt gs://BUCKET_NAME/new_name.txt

# Delete a specific object
gsutil rm gs://BUCKET_NAME/file.txt

# Delete all objects in bucket (but keep bucket)
gsutil rm -r gs://BUCKET_NAME/**

# Check object details/metadata
gsutil stat gs://BUCKET_NAME/file.txt