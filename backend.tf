terraform {
  backend "s3" {
    bucket = "infrastructure-tf-state"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

