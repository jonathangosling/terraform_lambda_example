terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}