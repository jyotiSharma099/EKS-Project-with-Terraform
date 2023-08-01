# Terraform Settings Block
terraform {
  required_version = "~> 1.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.70"
      version = "~> 4.65"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket  = "terraform-on-aws-eks-jyoti"
    key     = "dev/eks-cluster/terraform.tfstate"
    region  = "us-east-1"
    profile = "jyoti"

    # For State Locking
    dynamodb_table = "dev-eks-cluster"
  }
}

# Terraform Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "jyoti"
}