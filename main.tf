terraform {
  cloud {
    organization = "rio-hashicorp"
    workspaces {
      name = "deploy-aws-ec2"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
  provider "aws" {
    region = "us-west-2"
  }

  resource "aws_instance" "web1" {
    ami = "ami-08d70e59c07c61a3a"
    instance_type = "t2.micro"
    key_name = "key1"

    tags = {
    Name = "web1"
  }
  }

output "private_ip" {
  value = aws_instance.web1.private_ip
}

output "public_ip" {
  value = aws_instance.web1.public_ip
}