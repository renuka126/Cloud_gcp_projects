# Lab 1: Securing Container Builds


## What I did
In this lab, I focused on making container image builds more secure — writing a Dockerfile that follows security best practices and running a build through Cloud Build that includes vulnerability scanning.

## Key concepts
- Using minimal/distroless base images to reduce attack surface
- Running containers as a non-root user
- Scanning images for known vulnerabilities (CVEs) as part of the build
- Failing the build if critical vulnerabilities are found

## Files in this folder
- `Dockerfile` — a hardened sample Dockerfile following the practices from the lab
- `cloudbuild.yaml` — build config that builds the image and runs a vulnerability scan step

## What I learned
Security isn't just an add-on step at the end — it has to be baked into the build itself. Catching vulnerable dependencies at build time (instead of after deployment) saves a lot of pain later.
