provider "ct" {}

provider "aws" {
  region  = "eu-west-2"
}

terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "0.7.1"
    }
  }
}
