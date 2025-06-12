variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "ID подходящего Ubuntu AMI"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Name for the key pair"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
}
