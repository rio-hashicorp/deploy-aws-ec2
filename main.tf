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

output "nomad_private_ip" {
  value = aws_instance.nomad-dev.private_ip
}

output "nomad_public_ip" {
  value = aws_instance.nomad-dev.public_ip
}

output "vault_private_ip" {
  value = aws_instance.vault-dev.private_ip
}

output "Vault_Public_IP_Address" {
  value = aws_instance.vault-dev.public_ip
}