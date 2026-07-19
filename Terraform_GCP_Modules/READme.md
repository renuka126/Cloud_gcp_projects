# Terraform GCP Modules

Hands-on practice with Terraform modules on Google Cloud Platform.

## Contents

- **registry-module-demo/** — Using a public Terraform Registry module 
  (`terraform-google-modules/network/google`) to provision a custom VPC 
  with multiple subnets, each with different flow log and private access settings.

- **custom-module-demo/** — Building a reusable local module from scratch: 
  a Cloud Storage bucket configured for static website hosting, with 
  configurable lifecycle rules, versioning, retention policy, and encryption.

## Skills demonstrated
- Terraform Registry modules and version pinning
- Root module input/output variable design
- Building custom local modules with proper file structure (main.tf, variables.tf, outputs.tf)
- GCS static website hosting configuration
- Dynamic blocks for optional Terraform resource configuration