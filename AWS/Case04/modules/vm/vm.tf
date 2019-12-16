/*------------------- Virtual machine ------------------------*/
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.vm_config.vm_size
  key_name      = "terraform-demo"

  tags = {
    Name = var.vm_config.name
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# RUN THE APPLICATION
# ---------------------------------------------------------------------------------------------------------------------

resource "null_resource" "startupscript" {
  //count = "${var.vm_count}"
  depends_on = [aws_instance.web]

  //  triggers = {
  //    cluster_instance_ids = google_compute_instance.vm[count.index].instance_id
  //  }

  lifecycle {
    create_before_destroy = true
  }

  connection {
    //host = "${element(google_compute_instance.vm[*].network_interface.0.access_config.0.nat_ip, count.index)}"
    host        = aws_instance.web.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("//Users/sergii.marchenko/.ssh/for-test-servers")
  }

  provisioner "remote-exec" {
    inline = [
      "curl -L https://packagecloud.io/golang-migrate/migrate/gpgkey | sudo apt-key add -",
      "sudo bash -c \"echo 'deb https://packagecloud.io/golang-migrate/migrate/ubuntu/ $(lsb_release -sc) main' > /etc/apt/sources.list.d/migrate.list\" ",
      "sudo apt-get update",
      "sudo apt-get install -y migrate",
      "git clone https://github.com/s-marchenko/postgresql-go.git",
      "migrate -source file:/home/ubuntu/postgresql-go/code/migrations -database postgres://devops:foobarbaz@${var.connection_string.ip}:5432/peopleDatabase?sslmode=disable up 1",
      "curl -L https://github.com/s-marchenko/postgresql-go/releases/download/${var.code_version}/website_linux_amd64 --output postg",
      "sudo chmod 755 postg",
      "echo #!/bin/bash > start.sh",
      "echo export DBPORT=${var.connection_string.port} >> start.sh",
      "echo export DBHOST=${var.connection_string.ip} >> start.sh",
      "echo export DBUSER=devops >> start.sh",
      "echo export DBPASS=foobarbaz >> start.sh",
      "echo export DBNAME=peopleDatabase >> start.sh",
      "echo './postg' >> start.sh",
      "chmod 755 start.sh",
      "sudo nohup ./start.sh > /dev/null 2>&1 < /dev/null &",
      "sleep 1",
      "echo Finished",
    ]
  }
}

