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

resource "aws_security_group_rule" "allow_all" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["179.151.244.26/32"]

  security_group_id = data.aws_security_groups.test.ids[0]
}