terraform {
  backend "s3" {
    bucket = "devops-flow"
    key    = "terraform.state"
    region = "us-east-2"
  }
}