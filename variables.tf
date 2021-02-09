variable "name" {
  type        = string
  description = "name of your infrastructure"
  default     = "infra"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "os_image" {
  type        = string
  description = "AMI channel for a Container Linux derivative (flatcar-stable, flatcar-beta, flatcar-alpha, flatcar-edge)"
  default     = "flatcar-stable"

  validation {
    condition     = contains(["flatcar-stable", "flatcar-beta", "flatcar-alpha", "flatcar-edge"], var.os_image)
    error_message = "The os_image must be flatcar-stable, flatcar-beta, flatcar-alpha, or flatcar-edge."
  }
}

variable "disk_size" {
  type        = number
  description = "Size of the EBS volume in GB"
  default     = 10
}

variable "disk_type" {
  type        = string
  description = "Type of the EBS volume (e.g. standard, gp2, io1)"
  default     = "gp2"
}

variable "disk_iops" {
  type        = number
  description = "IOPS of the EBS volume (e.g. 100)"
  default     = 0
}

variable "worker_price" {
  type        = number
  description = "Spot price in USD for worker instances or 0 to use on-demand instances"
  default     = 0
}

# configuration

variable "ssh_authorized_key" {
  type        = string
  description = "SSH public key for user 'core'"
}

variable "host_cidr" {
  type        = string
  description = "CIDR IPv4 range"
  default     = "10.0.0.0/16"
}

variable "snippets" {
  type        = list(string)
  description = "Container Linux Config snippets"
  default     = []
}

variable "spot_price" {
  type        = number
  description = "Spot price in USD for worker instances or 0 to use on-demand instances"
  default     = 0
}

variable "worker_count" {
  type        = number
  description = "Number of instances"
  default     = 1
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}

variable "traefic_version" {
  type        = string
  description = "Traefic version"
  default     = "v2.4"
}

variable "unifi_version" {
  type        = string
  description = "UNIFI version"
  default     = "amd64-version-6.0.45"
}

variable "acme_email" {
  type        = string
  description = "ACME email"
}
