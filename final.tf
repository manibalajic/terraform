

resource "aws_vpc" "final" {
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" =  "${terraform.workspace}-VPC"
    }
}


resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.final.id
    for_each = toset(var.publiccidrs)
    cidr_block = each.key
}

resource "aws_eip" "publiceip" {
      
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.final.id
  
}

resource "aws_nat_gateway" "natgw" {
    allocation_id = aws_eip.publiceip.allocation_id
    subnet_id = aws_subnet.public-1["10.0.1.0/24"].id
    depends_on = [ aws_eip.publiceip ]
}

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.final.id
  route {
    cidr_block = aws_subnet.public-1["10.0.1.0/24"].id #attribute access syntax
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt-pub-association" {
    for_each = aws_subnet.public-1
    subnet_id = each.value.id
    route_table_id = aws_route_table.rt-public.id
}


# resource "aws_subnet" "private-1" {
#   vpc_id = aws_vpc.final.id
#   count = length(var.privatecidrs)
#   cidr_block = var.privatecidrs[count.index]

# }

resource "aws_subnet" "private-a" {
    vpc_id = aws_vpc.final.id
    for_each = var.samps
    cidr_block = each.value.cidr_block


  
}

# resource "aws_route_table" "rt-private" {
#     vpc_id = aws_vpc.final.id
#     route {
#       cidr_block = aws_subnet.private-1[0].cidr_block
#       gateway_id = aws_nat_gateway.natgw.id
        
#     }  
# }

resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.final.id
  route{
    cidr_block = aws_subnet.private-a["subnet"].cidr_block
    gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "rt-priv-association" {
    subnet_id = aws_subnet.private-a["subnet"].id
    route_table_id = aws_route_table.rt-private.id  
}
  

resource "aws_security_group" "public-SG" {
  vpc_id = aws_vpc.final.id
   
}

locals {
  ports = [ for each in var.ports: each ]
}

resource "aws_vpc_security_group_ingress_rule" "ingress-pub" {
    security_group_id = aws_security_group.public-SG.id
    count = length(local.ports)
    from_port = local.ports[count.index]
    to_port = local.ports[count.index]
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0" #FOR SG as SOURCE, USE referenced_security_group_id 
  
}



# output "test" {
#   value = [for each in aws_subnet.public-1[*].id: each]
  
# }



