# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal AWS infrastructure managed with Terraform. Single-environment deployment in eu-west-2 managing Route53 DNS and IAM for the `kombor.ski` domain.

## Commands

```bash
terraform init          # Initialize (S3 backend)
terraform fmt           # Format code
terraform validate      # Validate syntax
terraform plan          # Preview changes
terraform apply         # Deploy to AWS
```

CI (GitHub Actions on push to main) runs: fmt → init → validate → plan → apply.

## Architecture

Flat Terraform layout, no modules or workspaces — all resources in root:

- **dns.tf** — Route53 hosted zone and DNS records for kombor.ski (internal services point to 172.31.255.3, external services via CNAMEs)
- **users.tf** — IAM robot user for Traefik with scoped Route53 permissions (LetsEncrypt ACME DNS challenges)
- **backend.tf** — S3 remote state (`infrastructure-tf-state` bucket)
- **providers.tf** — AWS provider config
- **variables.tf** — Input variables (`aws_region`)

## Key Details

- Terraform version: 1.13.4+ (pinned in CI)
- AWS provider version pinned via `.terraform.lock.hcl` (committed)
- Secrets (AWS creds, `TF_VAR_SSH_AUTHORIZED_KEY`, `TF_VAR_ACME_EMAIL`) are in GitHub Actions secrets, never in code
- Dependabot updates Terraform providers and GitHub Actions daily
