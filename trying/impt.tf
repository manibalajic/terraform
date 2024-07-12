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

resource "aws_instance" "import" {
    ami =  "ami-0f58b397bc5c1f2e8"
    instance_type = "t2.micro"
    tags = {
      "Name" = "Terraform"
      "another" = "tag"
    }
    lifecycle {
      ignore_changes = [ tags ]
      prevent_destroy = true
    }
  
}

resource "aws_security_group" "SGs" {
  name = "SGforProvisioners"
    
}

resource "aws_vpc_security_group_ingress_rule" "sgrules" {
  from_port = "22"
  to_port = "22"
  cidr_ipv4  = "0.0.0.0/0" 
  ip_protocol = "tcp"
  security_group_id = aws_security_group.SGs.id

    
  }
  
  # resource "aws_vpc_security_group_ingress_rule" "sg2" {
  #    from_port = "443"
  # to_port = "443"
  # cidr_ipv4  = "0.0.0.0/0" 
  # ip_protocol = "tcp"
  # security_group_id = aws_security_group.SGs.id
    
  # }


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
  value = data.aws_ami.ubuntu.id
  
}

# resource "aws_instance" "test" {
#     ami =  "ami-0f58b397bc5c1f2e8"
#     instance_type = "t2.micro"
#     key_name = "forwindows"
#     vpc_security_group_ids = [ aws_security_group.SGs.id , aws_vpc_security_group_ingress_rule.sg2.id]
#     tags = {
#       "Name" = "testingprovisioner"
#       "another" = "tag"
#     }
#     root_block_device {
#       volume_size = "10"
#       encrypted = true
#       delete_on_termination = true

#     }
#     lifecycle {
#       ignore_changes = [ tags ]
#       # prevent_destroy = true
#     }
#     provisioner "file" {
#       source = "C:\\Users\\Mani\\Downloads\\Terraform\\policyEC2"
#       destination = "/home/ubuntu/policyEC2"
         
#     } 
#     connection {
#       type = "ssh"
#       private_key = file("C:\\Users\\Mani\\Downloads\\forwindowsConverted.pem")
#       host = self.public_ip
#       user = "ubuntu"

#     }  
  
# }

  
