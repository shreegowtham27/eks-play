terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.4.0"
    }
  }
}
provider "aws" {
  region="ap-south-1"
  profile = "recticart-terraform"
}