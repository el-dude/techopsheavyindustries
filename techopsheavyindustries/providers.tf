terraform {
  #required_version  = "~> 1.1.7"
  required_version  = "~> 1.3.9"

  required_providers {
    aws = {
      source        = "hashicorp/aws"
      version       = "~> 4.57.0"
    }
  }

  backend "s3" {
    bucket          = "techopsheavyindustries-terraform-east-1"
    key             = "state.tfstate"
    region          = "us-east-1"
    profile         = "el-dude"
  }
}

// This block tells Terraform to provision AWS resources.
provider "aws" {
  region          = "us-east-1"
  profile         = "el-dude"
}

