# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal infrastructure managed with Terraform, hosting DNS for the `kombor.ski` domain.

**Migration in progress:** authoritative DNS is moving from AWS Route53 to [deSEC](https://desec.io) (German non-profit, free, DNSSEC-by-default). Both zones are defined in this repo; Route53 remains authoritative until the nameservers are switched at the registrar, which is a manual step outside Terraform. Terraform state stays in S3 for now, so AWS credentials remain necessary even after Route53 is gone.

## Commands

```bash
terraform init          # Initialize (S3 backend)
terraform fmt           # Format code
terraform validate      # Validate syntax
terraform plan          # Preview changes
terraform apply         # Deploy
```

CI (GitHub Actions) runs fmt → init → validate → plan on every pull request, and additionally applies on a push to main. Pull requests stop at plan.

## Architecture

Flat Terraform layout, no modules or workspaces — all resources in root:

- **desec.tf** — deSEC zone and RRsets for kombor.ski (the migration target). Note deSEC's syntax: `rdata` not `records`, `subname` is a bare label with `@` for the apex, CNAME/MX targets need a trailing dot, and TXT/CAA values need literal quote characters inside the string.
- **tokens.tf** — deSEC API token for Traefik, scoped by token policy to TXT writes within kombor.ski only (LetsEncrypt ACME DNS-01 challenges)
- **data.tf** — data sources (currently the deSEC-assigned NS RRset)
- **outputs.tf** — deSEC nameservers, DNSSEC DS records for the registrar, and the Traefik token (sensitive)
- **dns.tf** — Route53 hosted zone and records (being retired; also defines the `locals` record sets shared with `desec.tf`)
- **users.tf** — IAM robot user for Traefik with scoped Route53 permissions (being retired)
- **backend.tf** — S3 remote state (`infrastructure-tf-state` bucket); stays on AWS for now
- **providers.tf** — provider requirements and config for `aws` and `desec`
- **variables.tf** — Input variables (`aws_region`, `desec_api_token`)

## Key Details

- Terraform version: 1.15.8 (pinned in CI)
- Provider versions pinned via `.terraform.lock.hcl` (committed)
- Secrets (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `TF_VAR_DESEC_API_TOKEN`) are in GitHub Actions secrets, never in code. Every secret has a live consumer — don't add one without a matching `variable` block, or Terraform will silently ignore it
- Write Terraform without comments, matching the rest of the repo
- deSEC enforces a **minimum TTL of 3600** on custom domains — RRsets below that are rejected with HTTP 400
- deSEC rate-limits RRset writes to 15/min per domain; the provider retries 429s and serialises per-domain requests, so a bulk apply is slow but self-correcting
- Dependabot updates Terraform providers and GitHub Actions daily
