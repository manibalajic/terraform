data "aws_availability_zones" "dev_env" {
  
}

locals {
  zones = {for k,zone in data.aws_availability_zones.dev_env.names: k=> zone}
}

output "zone" {
    value = local.zones[0]
  
}

resource "aws_ebs_volume" "dev" {
    availability_zone = local.zones[0]
    type = "gp2"
    size = "10"
    tags = {
      "Name" = "fordev" 
    }
  
}

resource "aws_volume_attachment" "forinstace" {
    instance_id = aws_instance.import.id
    volume_id = aws_ebs_volume.dev.id
    device_name = "/dev/xvdf"
}