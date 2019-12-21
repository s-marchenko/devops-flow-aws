provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t2.micro"
  count         = length(var.instance_names)
  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  type    = list(string)
  default = ["name1", "name2"]
}

output "ip" {
  value = [
    for instance in aws_instance.example : instance.public_ip
  ]
}