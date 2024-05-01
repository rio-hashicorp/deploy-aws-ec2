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


  resource "aws_instance" "nomad-dev" {
    ami = "ami-023e152801ee4846a" #Deploy Amazon Linux 2023 AMI
    instance_type = "t2.micro"
    key_name = "key1"

    tags = {
    Name = "nomad-dev"
  }
  }

    resource "aws_instance" "vault-dev" {
    ami = "ami-023e152801ee4846a" #Deploy Amazon Linux 2023 AMI
    instance_type = "t2.micro"
    key_name = "key1"

    tags = {
    Name = "vault-dev"
  }
  }

output "private_ip" {
  value = aws_instance.web1.private_ip
}

output "public_ip" {
  value = aws_instance.web1.public_ip
}