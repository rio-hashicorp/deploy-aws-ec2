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
    ami = "ami-023e152801ee4846a" #Deploy Amazon Linux 2023 AMI
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