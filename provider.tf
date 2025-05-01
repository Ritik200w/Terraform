terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0" # Specify a version constraint
    }
  }
}


provider "aws" {
  region = var.region

}
