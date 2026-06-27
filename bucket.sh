# Basic bucket creation
gsutil mb gs://BUCKET_NAME

# Create bucket in a specific region
gsutil mb -l us-central1 gs://BUCKET_NAME

# Create bucket with storage class
gsutil mb -c STANDARD gs://BUCKET_NAME

# Create bucket with both region and storage class
gsutil mb -l us-central1 -c STANDARD gs://BUCKET_NAME

#After creation of bucket :

# Verify bucket was created
gsutil ls

# Check bucket details
gsutil ls -L gs://BUCKET_NAME

# Upload a file to bucket
gsutil cp file.txt gs://BUCKET_NAME/

# Delete the bucket
gsutil rm -r gs://BUCKET_NAME