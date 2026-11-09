terraform {
  required_version = ">= 1.5"

  backend "s3" {
    bucket       = "s3-file-api-tf-state"
    key          = "s3-file-api/prod/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true

    assume_role = {
      role_arn     = "arn:aws:iam::731770490737:role/terraformProdRole"
      session_name = "terraform-backend"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"

  assume_role {
    role_arn     = var.iam_assume_role
    session_name = "terraform-infrastructure"
  }
}