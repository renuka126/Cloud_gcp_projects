#!/bin/bash
# deploy-pipeline.sh
# End-to-end secure delivery pipeline: build -> scan -> sign -> deploy
# Combines everything from labs 1-3 into a single flow.

set -e

PROJECT_ID=$(gcloud config get-value project)
REGION="us-central1"
REPO="my-repo"
IMAGE="my-app"
CLUSTER="my-gke-cluster"
ATTESTOR="my-attestor"
KEYRING="binauthz-keyring"
KEY="binauthz-key"

echo "Step 1: Build and push the image"
IMAGE_URI="$REGION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE:$(git rev-parse --short HEAD)"
gcloud builds submit --tag "$IMAGE_URI" .

echo "Step 2: Get the image digest (Binary Authorization needs digests, not tags)"
DIGEST=$(gcloud artifacts docker images describe "$IMAGE_URI" --format='value(image_summary.digest)')
IMAGE_WITH_DIGEST="$REGION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE@$DIGEST"

echo "Step 3: Scan for vulnerabilities"
gcloud artifacts docker images list-vulnerabilities "$IMAGE_WITH_DIGEST" \
  --format='value(vulnerability.effectiveSeverity)' > /tmp/severities.txt

if grep -q "CRITICAL" /tmp/severities.txt; then
  echo "Critical vulnerabilities found. Stopping pipeline."
  exit 1
fi

echo "Step 4: Sign the image (create attestation)"
gcloud beta container binauthz attestations sign-and-create \
  --artifact-url="$IMAGE_WITH_DIGEST" \
  --attestor="$ATTESTOR" \
  --attestor-project="$PROJECT_ID" \
  --keyversion-project="$PROJECT_ID" \
  --keyversion-location=global \
  --keyversion-keyring="$KEYRING" \
  --keyversion-key="$KEY" \
  --keyversion=1

echo "Step 5: Deploy to GKE (will only succeed if attestation is valid)"
gcloud container clusters get-credentials "$CLUSTER" --region "$REGION"

kubectl set image deployment/my-app-deployment \
  my-app-container="$IMAGE_WITH_DIGEST"

echo "Pipeline complete. Image deployed under enforced Binary Authorization policy."
