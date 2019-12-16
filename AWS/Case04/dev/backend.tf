terraform {
  backend "s3" {
    bucket = "devops-flow"
    key    = "terraform-case04.state"
    region = "us-east-2"
  }
}