variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}

variable "desec_api_token" {
  type        = string
  description = "deSEC API token used by Terraform to manage the zone"
  sensitive   = true
}
