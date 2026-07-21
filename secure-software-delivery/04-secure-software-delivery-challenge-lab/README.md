# Lab 4: Secure Software Delivery — Challenge Lab


## What I did
This was the final challenge lab that tied everything together — building a container, scanning it, signing it via an attestor, and deploying it to GKE under an enforced Binary Authorization policy, all without step-by-step hand-holding (challenge labs give you a goal, not the exact commands).

## What it combined
- Secure Dockerfile + build practices from Lab 1
- Automated Cloud Build pipeline from Lab 2
- Attestor + Binary Authorization policy from Lab 3
- A full deploy to GKE that only succeeds because the image is properly attested

## Files in this folder
- `deploy-pipeline.sh` — end-to-end script covering build → scan → sign → deploy

## What I learned
This challenge lab was a good test of whether I actually understood the pieces individually, rather than just following instructions. Putting it together end-to-end made it click how these Google Cloud security tools (Cloud Build, Artifact Registry scanning, KMS, Binary Authorization) all connect into one pipeline.
