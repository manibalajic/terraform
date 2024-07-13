data "aws_availability_zones" "dev_env" {

}

locals {
  zones = { for k, zone in data.aws_availability_zones.dev_env.names : k => zone }
}

output "zone" {
  value = local.zones[0]

}

# resource "aws_ebs_volume" "dev" {
#     availability_zone = local.zones[0]
#     type = "gp2"
#     size = "10"
#     tags = {
#       "Name" = "fordev" 
#     }

# }

# resource "aws_volume_attachment" "forinstace" {
#     instance_id = aws_instance.import.id
#     volume_id = aws_ebs_volume.dev.id
#     device_name = "/dev/xvdf"
# }

data "aws_subnets" "for_lb" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_id.id]
  }

}

data "aws_vpc" "default_id" {
  default = true

}

output "lb_vpc" {
  # value = [for each in data.aws_subnets.for_lb.ids: each ]
  value = data.aws_subnets.for_lb.ids[0]
}
resource "aws_lb" "testing" {
  name               = "testing"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_vpc_security_group_ingress_rule.sg2.id]
  subnets            = [data.aws_subnets.for_lb.ids[0], data.aws_subnets.for_lb.ids[1]]
}

resource "aws_lb_listener" "testing" {
  load_balancer_arn = aws_lb.testing.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.testingTG.arn

  }
}

resource "aws_lb_target_group" "testingTG" {
  name     = "TGtesting"
  port     = 80
  protocol = "http"
  vpc_id   = data.aws_vpc.default_id.id

}

resource "aws_lb_target_group_attachment" "tg-instance" {
  target_group_arn = aws_lb_target_group.testingTG.arn
  target_id        = aws_instance.test.id

}