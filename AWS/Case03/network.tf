# Lookup default vpc ID
data "aws_vpc" "vpc" {
  default = true
}

# Lookup the first SG in the default VPC
data "aws_security_groups" "test" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
}

# Configure a security rule
resource "aws_security_group_rule" "allow_all" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = var.witelist

  security_group_id = data.aws_security_groups.test.ids[0]
}