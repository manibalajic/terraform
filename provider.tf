terraform {
  required_version = ">1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.45.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "whateverworksfornow"
    key            = "whateverworksfornow/for_terraform/terraform.tfstate"
    encrypt        = true
    region         = "ap-south-1"
    dynamodb_table = "terraform"

  }
}

provider "aws" {
  region = "ap-south-1"
}



