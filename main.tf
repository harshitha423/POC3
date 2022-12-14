#Defining the Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
terraform {
  backend "s3" {
    bucket     = "samplepocbuckett"
    key        = "test.tfstate"
    region     = "ap-south-1"
    access_key    = "AKIARML37IA2QEPN4Z4H"
    secret_key    = "USjj5ub5ARd95q9pMm+IrlJL2Ro7yqsmaUsmhTIs"
  }
}

data "aws_ami" "linux_machine" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name    = "name"
    values  = ["amzn-ami-hvm*"]
  }
  
  filter {
    name    = "root-device-type"
    values  = ["ebs"]
  }
  
  filter {
    name    = "virtualization-type"
    values  = ["hvm"]
  }
}

#Creating web server instance in Web_sub
resource "aws_instance" "web_server" {
  instance_type = var.instance_type
  ami           = data.aws_ami.linux_machine.id
  tags = {
    Name = "web_server"
  }
}
output "instance_ip_addr" {
  value = aws_instance.web_server.public_ip
}
