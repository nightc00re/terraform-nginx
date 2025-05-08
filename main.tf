provider "aws" {
  region = "us-east-2"
}

data "aws_region" "current" {}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Amazon Linux 2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "nginx_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = "your-key-name"  # Replace with your key pair
  subnet_id     = "your-subnet-id" # Replace with a subnet ID in us-east-2
  security_groups = ["your-security-group-id"]  # Replace with a security group ID in us-east-2
  tags = {
    Name = "NginxInstance"
  }
  user_data = file("nginx-install.sh")
  # availability_zone = "us-east-2a" #Optional, but good practice
}
