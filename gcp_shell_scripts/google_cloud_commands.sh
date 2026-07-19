# Google Cloud Shell - Basic Commands

# Check current project
gcloud config get-value project

# Set project
gcloud config set project PROJECT_ID

# Check logged-in account
gcloud auth list

# List VM instances
gcloud compute instances list

# Create VM
gcloud compute instances create my-vm --zone=us-central1-a

# Connect to VM
gcloud compute ssh my-vm --zone=us-central1-a

# Start/Stop VM
gcloud compute instances start my-vm --zone=us-central1-a
gcloud compute instances stop my-vm --zone=us-central1-a

# Delete VM
gcloud compute instances delete my-vm --zone=us-central1-a

# List storage buckets
gcloud storage buckets list

# Create bucket
gcloud storage buckets create gs://my-bucket-name

# Upload file
gcloud storage cp file.txt gs://my-bucket-name

# Enable API
gcloud services enable compute.googleapis.com

# List enabled APIs
gcloud services list

# Check configuration
gcloud config list

# Check gcloud version
gcloud version

# Help
gcloud help