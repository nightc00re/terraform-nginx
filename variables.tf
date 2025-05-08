variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "The name of the EC2 key pair to use"
  type        = string
  default     = "ronaldo.pem"  # Make sure this matches your key pair name
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t3.micro"
}
