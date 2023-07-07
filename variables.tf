
variable "instance_type" {
    description = "webserver"
    default = "t2.micro"
    type = string
  
}

variable "availability_zone" {
    description = "availability zone"
    default = "us-east-1a"
    type = string
  
}

variable "AMI" {
    description = "amazon machine"
    default = "ami-04823729c75214919"
    type = string

}
