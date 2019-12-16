resource "aws_db_instance" "default" {
  allocated_storage   = 5
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "9.6.9"
  instance_class      = var.db_config.db_size
  identifier          = "${var.db_config.env_tag}-flow-db"
  name                = var.db_config.name
  username            = "devops"
  password            = "foobarbaz"
  skip_final_snapshot = true
}

