terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.22.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "= 2.11.0"
    }
  }

  required_version = "= 1.5.2"

  backend "s3" {
    key    = "data-mesh/infrastructure-foundation"
    region = var.region
  }
}