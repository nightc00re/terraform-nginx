terraform {
  required_version = ">= 1.5" # Or your required version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Or your required version
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
