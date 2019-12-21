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

variable "ingress_ports" {
  type        = list(number)
  description = "Some list of ingress ports"
  default     = [80, 443]
}

resource "aws_security_group" "allow_all" {
  name        = "some_rg"
  description = "ingress for some_rg"
  vpc_id      = data.aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["178.151.244.26/32"]
    }
  }
}