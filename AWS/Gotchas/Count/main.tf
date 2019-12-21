provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t3.nano"
  count         = length(var.instance_names)
  tags = {
    Name = var.instance_names[count.index]
  }
}

variable "instance_names" {
  type    = list(string)
  default = ["name1", "name2"]
}