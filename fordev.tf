
locals {
  instance_name= "${terraform.workspace}-instance"
}
resource "aws_instance" "fordev" {
    instance_type = var.instance_type
    ami = "ami-0f58b397bc5c1f2e8"

    tags = {
      Name = local.instance_name
    }
}

data "aws_availability_zones" "available" {

  filter {
    name = "zone-name"
    values = ["ap-south-1a"]

  }
}



locals {
  zones={for index,zones in data.aws_availability_zones.available.names: index => zones }
}

