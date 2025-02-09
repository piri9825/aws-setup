terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "${var.project_name}-${var.state_bucket}"
    key    = var.state_key
    region = var.region
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}