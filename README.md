# EC2Webserver

Define AWS Provider: Specify the AWS provider in your Terraform configuration to define the region and authentication credentials.

Create an S3 Bucket: Use the aws_s3_bucket resource to create an S3 bucket where your website files will be stored.

Configure S3 Bucket Policy: Define an S3 bucket policy using the aws_s3_bucket_policy resource to grant read access to the bucket contents.

Create an IAM Role: Use the aws_iam_role resource to create an IAM role that provides necessary permissions for the ECS instance to interact with other AWS services.

Attach IAM Policy: Attach an IAM policy to the IAM role using the aws_iam_role_policy_attachment resource. This policy should allow access to the S3 bucket and any other required resources.

Create a VPC: Use the aws_vpc resource to create a Virtual Private Cloud (VPC) for your ECS instance.

Define Subnets: Create one or more subnets within the VPC using the aws_subnet resource. Ensure at least one subnet is public for the ECS instance to have internet access.

Create Security Group: Use the aws_security_group resource to define a security group that allows inbound traffic on ports 80 (HTTP), 144 (HTTPS), and 22 (SSH).

Configure Routing: Create an internet gateway using the aws_internet_gateway resource and attach it to the VPC. Set up a public route table and add routes to the internet gateway using the aws_route_table and aws_route resources.

Launch EC2 Instance: Use the aws_instance resource to launch an EC2 instance within the public subnet. Specify the appropriate AMI, instance type, and associate the IAM role and security group. The script below was inserted into the user data block of the ec2 :
sudo su
yum update -y |
yum install httpd -y |
systemctl enable httpd |
systemctl start httpd |
cd /var/www/html |
sudo aws s3 sync s3://xmenproject-bucket /var/www/html # replace bucket name with your bucket name |
sudo mv xmen-main/* . |
systemctl restart http

Apply and Deploy: Run terraform init to initialize the Terraform project, terraform plan to preview the changes, and terraform apply to deploy the resources.
