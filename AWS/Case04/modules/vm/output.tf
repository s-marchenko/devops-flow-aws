output "instance_connection" {
  value = "ssh -i ~/.ssh/for-test-servers ubuntu@${aws_instance.web.public_ip}"
}