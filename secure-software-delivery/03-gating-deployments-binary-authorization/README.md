# Lab 3: Gating Deployments with Binary Authorization


## What I did
This was the core lab of the badge. I set up Binary Authorization so that only container images that have been signed/attested by a trusted authority can be deployed to GKE — anything unsigned gets blocked automatically.

## Key concepts
- **Attestors** — an entity that vouches an image passed a specific check (e.g. vulnerability scan, QA sign-off)
- **Attestations** — the actual signed statement tied to a specific image digest
- **Binary Authorization policy** — the rule set that says "only deploy images with attestation X from attestor Y"
- KMS keys used to sign attestations

## Steps followed
1. Created a KMS keyring and key pair for signing
2. Created an attestor in Binary Authorization and associated it with the KMS key
3. Signed a built image to create an attestation
4. Wrote a Binary Authorization policy requiring that attestation for any deploy
5. Tried deploying an unsigned image (blocked) vs a signed image (allowed)

## Files in this folder
- `policy.yaml` — the Binary Authorization policy used to gate deployments
- `attestor-setup.sh` — commands to create the KMS key, attestor, and sign an image

## What I learned
This connects nicely with my earlier KMS labs — Binary Authorization is essentially KMS-backed signing enforced at deploy time. It's a strong way to guarantee that only images which passed your security checks (from labs 1 and 2) ever make it to production.
