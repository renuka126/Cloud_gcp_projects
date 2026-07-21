#!/bin/bash
# attestor-setup.sh
# Sets up a KMS signing key, a Binary Authorization attestor,
# and signs an image to create an attestation.

set -e

PROJECT_ID=$(gcloud config get-value project)
KEYRING="binauthz-keyring"
KEY="binauthz-key"
ATTESTOR="my-attestor"
NOTE_ID="my-attestor-note"
IMAGE_PATH="us-central1-docker.pkg.dev/$PROJECT_ID/my-repo/my-app@sha256:REPLACE_WITH_DIGEST"

echo "1. Creating KMS keyring and key..."
gcloud kms keyrings create "$KEYRING" --location=global

gcloud kms keys create "$KEY" \
  --keyring="$KEYRING" \
  --location=global \
  --purpose=asymmetric-signing \
  --default-algorithm=ec-sign-p256-sha256

echo "2. Creating a Container Analysis Note for the attestor..."
cat > /tmp/note.json << EOF
{
  "attestation": {
    "hint": {
      "human_readable_name": "My Attestor Note"
    }
  }
}
EOF

curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  --data-binary @/tmp/note.json \
  "https://containeranalysis.googleapis.com/v1/projects/$PROJECT_ID/notes/?noteId=$NOTE_ID"

echo "3. Creating the Binary Authorization attestor..."
gcloud container binauthz attestors create "$ATTESTOR" \
  --attestation-authority-note="$NOTE_ID" \
  --attestation-authority-note-project="$PROJECT_ID"

echo "4. Linking the KMS key to the attestor..."
gcloud container binauthz attestors public-keys add \
  --attestor="$ATTESTOR" \
  --keyversion-project="$PROJECT_ID" \
  --keyversion-location=global \
  --keyversion-keyring="$KEYRING" \
  --keyversion-key="$KEY" \
  --keyversion=1

echo "5. Signing the image to create an attestation..."
gcloud beta container binauthz attestations sign-and-create \
  --artifact-url="$IMAGE_PATH" \
  --attestor="$ATTESTOR" \
  --attestor-project="$PROJECT_ID" \
  --keyversion-project="$PROJECT_ID" \
  --keyversion-location=global \
  --keyversion-keyring="$KEYRING" \
  --keyversion-key="$KEY" \
  --keyversion=1

echo "Done. Image is now attested and can be deployed under the enforced policy."
