
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