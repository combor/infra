terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.58"
    }
    desec = {
      source  = "timofurrer/desec"
      version = "~> 0.6"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "desec" {
  api_token = var.desec_api_token
}
