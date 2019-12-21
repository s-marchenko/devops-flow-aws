data "aws_vpc" "vpc" {
  default = true
}

output "vpc" {
  value = data.aws_vpc.vpc.id
}

data "aws_security_groups" "test" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

output "sg" {
  value = data.aws_security_groups.test.ids
}

locals {
  ingress_type = "ingress"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all" {
  type        = local.ingress_type
  from_port   = 0
  to_port     = 65535
  protocol    = local.tcp_protocol
  cidr_blocks = [local.all_ips]

  security_group_id = data.aws_security_groups.test.ids[0]
}