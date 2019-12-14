provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-02df9ea15c1778c9c"
  instance_type = "t3.nano"
  count         = 2
}