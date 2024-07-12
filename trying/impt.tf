terraform {
  required_version = ">1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.45.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = {
      "terraforms" = "true"
    }
  }
}

# import {
#   to= aws_instance.importing
#   id = "i-06fb2ec924bb69ba8"

# }
resource "aws_instance" "import" {
    ami =  "ami-0f58b397bc5c1f2e8"
    instance_type = "t2.micro"
    tags = {
      "Name" = "Terraform"
    }
  
}

data "aws_ami" "ubuntu" {
  owners = [ "099720109477" ]
  most_recent = true
   filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240423"]
   }
  }

# Ubuntu Server 24.04 LTS 

output "ubu" {
  value = data.aws_ami.ubuntu
  
}
