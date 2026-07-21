# Lab 2: Secure Builds with Cloud Build



## What I did
This lab focused on setting up Cloud Build triggers connected to a source repo, so every push automatically kicks off a secure build pipeline. I also configured build permissions so Cloud Build only has the access it actually needs (least privilege).

## Key concepts
- Cloud Build triggers (on push, on PR, etc.)
- Service account permissions for Cloud Build (least privilege)
- Storing build artifacts in Artifact Registry
- Build provenance — recording metadata about how an image was built

## Files in this folder
- `cloudbuild.yaml` — trigger-based build pipeline used in the lab

## What I learned
Automating builds is easy, but automating them *securely* means being careful about what permissions the build service account has, and making sure every build's origin can be traced back (provenance) — this becomes important later for Binary Authorization.
