# ☁️ Cloud GCP Projects

New to GCP? Tired of Googling the same commands over and over?
Me too. So I made this! 😄

A beginner-friendly cheat sheet for the most commonly used
Google Cloud commands — all in one place, making cloud
development faster and easier.

> ☁️ No more searching — just scroll and run!

## 📁 Repo Structure

- **`gcp_shell_scripts/`** — Ready-to-run gcloud/gsutil commands covering
  GCS bucket operations, IAM permissions, BigQuery, Compute Engine, load
  balancing, VM management, and networking.

- **`terraform_modules/`** — Terraform practice: using a public registry
  module to provision a VPC with subnets, and building a custom local
  module for a GCS static website bucket.
  - `registry-module-demo/` — VPC + subnets via `terraform-google-modules/network/google`
  - `custom-module-demo/` — Custom local module for a GCS static website bucket