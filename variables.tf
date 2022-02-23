variable "name" {
  type        = string
  description = "name of your infrastructure"
  default     = "infra"
}

variable "host_cidr" {
  type        = string
  description = "CIDR IPv4 range"
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}
