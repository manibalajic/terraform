locals {
    values= [ 22, 443]
}

resource "aws_security_group" "ingresss" {
    name = "ingress-web"

    dynamic "ingress" {
        for_each = toset(local.values)
        content {
          from_port = ingress.value
          to_port = ingress.value
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      
    }
  
}

locals {
  mapss={
    1 = "whatever"
    2 = "works"
  }
}

output "cal" {
  value = {for k,v in local.mapss : tostring(k) => v} 
}

resource "aws_instance" "web" {
  security_groups =[ aws_security_group.ingresss.name ]
  instance_type = "t2.micro"
  ami = "ami-0f58b397bc5c1f2e8"
  key_name = "forwindows"
}

