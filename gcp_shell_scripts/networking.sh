#!/bin/bash


# List all VPC networks
gcloud compute networks list

# Create a VPC network
gcloud compute networks create my-vpc --subnet-mode=auto

# List subnetworks
gcloud compute networks subnets list

# Create a firewall rule to allow HTTP traffic
gcloud compute firewall-rules create allow-http \
    --network=my-vpc \
    --allow=tcp:80

# List firewall rules
gcloud compute firewall-rules list

# Delete a firewall rule
gcloud compute firewall-rules delete allow-http --quiet