terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
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