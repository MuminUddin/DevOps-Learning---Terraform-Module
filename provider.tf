terraform {
  required_version = ">= 1.14.0, < 2.0.0" ## added in for CI worflow
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }

  /*
  backend "s3" {
    bucket = "terraform-state-mumin"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }*/
}

provider "aws" {
  # Configuration options
}