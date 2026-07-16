# Cloud Run Functions (Gen 2) — Multi-Trigger Demo

While working through Google Cloud Skills Boost lab GSP1089, I built and deployed
several Cloud Run Functions to understand how different triggers, revisions, and
scaling settings work in practice.

## What's in here

- `hello-http/` – A basic HTTP function (Node.js) with a longer timeout, since
  HTTP requests sometimes need more than the default response window.
- `hello-storage/` – A function that fires whenever a file lands in a Cloud
  Storage bucket. Useful for things like auto-processing uploads.
- `nodejs-pubsub-function/` – Triggered by Pub/Sub messages — this is the
  event-driven pattern I found most interesting, since the function only runs
  when something is actually published to the topic.
- `hello-world-colored/` – A small Python function used to explore how
  revisions work. I deployed it once with `COLOR=orange`, then redeployed
  a new revision with `COLOR=yellow` to see how traffic shifts to the latest
  version automatically.
- `min-instances/` – A Go function with a deliberately slow 10-second init,
  used to actually *feel* the cold-start problem, then fix it using
  `--min-instances`.

## Things I learned

- Cold starts are a real, measurable problem — the first request to
  `min-instances/` genuinely takes ~10 seconds without warm instances.
- Setting `--concurrency` higher lets one instance handle many requests
  at once, which reduces the need to spin up new instances for parallel load.
- Triggers aren't just "http vs not" — Pub/Sub and Storage triggers need
  their own IAM roles (`pubsub.publisher`, `eventarc.eventReceiver`) granted
  to the right service accounts before they'll even fire.

## Deploy examples

Pub/Sub function:
\`\`\`bash
gcloud functions deploy nodejs-pubsub-function \
  --gen2 --runtime nodejs22 --entry-point helloPubSub \
  --source . --region us-west1 --trigger-topic cf-demo \
  --allow-unauthenticated
\`\`\`

## Stack
Node.js 22, Python 3.11, Go 1.23, Functions Framework, gcloud CLI