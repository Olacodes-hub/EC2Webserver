provider "aws" {
  region  = "us-east-1"
  profile = "terraform-user"

}


resource "aws_instance" "example_instance" {

  ami                    = var.AMI # Replace with the desired AMI ID
  instance_type          = var.instance_type
  key_name               = "mykey"
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  subnet_id              = aws_subnet.subnet.id

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    echo "Hello, World!" > /var/www/html/index.html
    service httpd start
  EOF
}
