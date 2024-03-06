terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.3.0, < 6.0.0"
    }
  }
  required_version = ">= 0.14.11, < 2.0.0"
}