variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
  default     = "vpc-0b110d239f1211b4d"
}

variable "public_subnet_id" {
  description = "A PUBLIC subnet ID in the given VPC (must auto-assign public IPs)"
  type        = string
  default     = "subnet-0852a4e422a2ea812"
}


variable "instance_type" {
  description = "Instance type suitable for Docker"
  type        = string
  default     = "t3.medium"
}

variable "ssh_ingress_cidr" {
  description = "CIDR allowed to SSH to the instance"
  type        = string
  default     = "46.121.130.167/32"
}

variable "key_name" {
  description = "Logical name for the AWS key pair and local key files"
  type        = string
  default     = "builder"
}

variable "key_dir" {
  description = "Directory (relative) to store generated SSH keys locally"
  type        = string
  default     = "./keys"
}