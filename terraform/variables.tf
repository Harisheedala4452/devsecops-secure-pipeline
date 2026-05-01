variable "project_name" {
  description = "Name used for tagging AWS resources."
  type        = string
  default     = "devsecops-secure-pipeline"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.project_name))
    error_message = "project_name must be 3-63 lowercase letters, numbers, or hyphens, starting with a letter and ending with a letter or number."
  }
}

variable "environment" {
  description = "Deployment environment label."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "aws_region" {
  description = "AWS region for provider configuration."
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance. Replace with a valid regional AMI before applying."
  type        = string
  default     = "ami-1234567890abcdef0"

  validation {
    condition     = can(regex("^ami-[a-f0-9]{8,17}$", var.ami_id))
    error_message = "ami_id must look like a valid AWS AMI ID, for example ami-1234567890abcdef0."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the demo."
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t3.small", "t4g.micro", "t4g.small"], var.instance_type)
    error_message = "Use a small demo-safe instance type: t3.micro, t3.small, t4g.micro, or t4g.small."
  }
}

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed to reach HTTP. Restrict this before real deployment."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
