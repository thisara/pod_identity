terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket       = "s3-api-app-tf-state"
    key          = "s3-file-api/prod/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}