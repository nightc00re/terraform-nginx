variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-2" # Changed to us-east-2
}

variable "key_name" {
  description = "The name of the EC2 key pair to use"
  type        = string
  default     = "lebronjames" # Changed to lebronjames
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "project" {
  description = "Project name tag"
  type        = string
  default     = "nginx-vpc"
}
