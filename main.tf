provider "aws" {
  region  = "us-east-1"
  profile = "terraform-user"

}

# create s3 iam role
resource "aws_iam_role" "s3_role" {
  name = "S3AccessRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# attach s3 role to s3 policy
resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# create iam instance profile
resource "aws_iam_instance_profile" "example" {
  name = "S3AccessProfile"
  role = aws_iam_role.s3_role.name
}

# create ec2 instance
resource "aws_instance" "example" {
  ami           = var.AMI  # Replace with the desired AMI ID
  instance_type = var.instance_type     # Replace with the desired instance type
  key_name               = "mykey"
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  subnet_id              = aws_subnet.subnet.id
  iam_instance_profile = aws_iam_instance_profile.example.name

  user_data = <<-EOF
    #!/bin/bash
    sudo su
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    cd /var/www/html
    sudo aws s3 sync s3://xmenproject-bucket /var/www/html
    sudo mv xmen-main/* .
    systemctl restart httpd
  EOF
  
}
 

 
