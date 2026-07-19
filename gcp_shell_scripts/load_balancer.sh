#!/bin/bash

# List all backend services
gcloud compute backend-services list

# Create a health check
gcloud compute health-checks create http my-health-check \
    --port=80

# Create a backend service
gcloud compute backend-services create my-backend-service \
    --protocol=HTTP \
    --health-checks=my-health-check \
    --global

# List URL maps
gcloud compute url-maps list

# Create a URL map
gcloud compute url-maps create my-url-map \
    --default-service=my-backend-service

# Create a target HTTP proxy
gcloud compute target-http-proxies create my-http-proxy \
    --url-map=my-url-map

# Create a global forwarding rule
gcloud compute forwarding-rules create my-forwarding-rule \
    --global \
    --target-http-proxy=my-http-proxy \
    --ports=80

# List forwarding rules
gcloud compute forwarding-rules list

# Delete the forwarding rule
gcloud compute forwarding-rules delete my-forwarding-rule \
    --global \
    --quiet