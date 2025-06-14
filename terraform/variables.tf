variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  default     = "ami-020cba7c55df1f615"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "github-actions-key"
}

variable "public_key" {
  description = "Public SSH key content"
  type        = string
}
