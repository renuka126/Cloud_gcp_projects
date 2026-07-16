# Cloud Run Functions (2nd Gen) — Multi-Trigger Demo

Hands-on implementation of Google Cloud Run Functions (Gen 2) covering
multiple event sources, revision management, and performance tuning.
Based on Google Cloud Skills Boost lab GSP1089.

## Folder structure

| Folder | Language | Trigger Type | Purpose |
|---|---|---|---|
| `hello-http/` | Node.js | HTTP | Basic authenticated HTTP function with extended timeout |
| `hello-storage/` | Node.js | Cloud Storage | Responds to file uploads in a GCS bucket |
| `nodejs-pubsub-function/` | Node.js | Pub/Sub | Responds to messages published on a Pub/Sub topic |
| `hello-world-colored/` | Python | HTTP | Demonstrates revisions via environment variable changes |
| `min-instances/` | Go | HTTP | Demonstrates cold-start mitigation with `--min-instances` |

## Key concepts demonstrated

- **Event-driven triggers**: HTTP, Cloud Storage, Pub/Sub, Cloud Audit Logs
- **IAM setup**: granting `pubsub.publisher` and `eventarc.eventReceiver`
  roles to service accounts for cross-service event triggers
- **Revision management**: deploying multiple revisions of the same
  function with different environment variables (`COLOR=orange` → `yellow`)
- **Cold start reduction**: using `--min-instances` to keep function
  instances warm
- **Concurrency tuning**: increasing `--concurrency` so a single instance
  can handle multiple simultaneous requests, reducing the need for
  additional cold starts

## Example deploy commands

**HTTP function:**
```bash
gcloud functions deploy nodejs-http-function \
  --gen2 --runtime nodejs22 --entry-point helloWorld \
  --source . --region us-west1 --trigger-http \
  --timeout 600s --max-instances 1
```

**Pub/Sub function:**
```bash
gcloud functions deploy nodejs-pubsub-function \
  --gen2 --runtime nodejs22 --entry-point helloPubSub \
  --source . --region us-west1 --trigger-topic cf-demo \
  --allow-unauthenticated
```

**Storage function:**
```bash
gcloud functions deploy nodejs-storage-function \
  --gen2 --runtime nodejs22 --entry-point helloStorage \
  --source . --region us-west1 --trigger-bucket $BUCKET \
  --trigger-location us-west1 --max-instances 1
```

## Related sample referenced (not included as raw code)

The Cloud Audit Log function (`gce-vm-labeler`) used in this lab is sourced
from Google's official sample repo and listens for Compute Engine VM
creation events, auto-labeling new VMs with the creator's identity:
https://github.com/GoogleCloudPlatform/eventarc-samples/tree/main/gce-vm-labeler

## Tech stack
Node.js 22 · Python 3.11 · Go 1.23 · Google Cloud Functions Framework · gcloud CLI