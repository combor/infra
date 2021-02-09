provider "ct" {}

provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "0.7.1"
    }
  }
}
