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

  resource "aws_instance" "boundary_target" {
    ami = "ami-0cf2b4e024cdb6960" #Deploy Amazon Linux 2023 AMI
    instance_type = "t2.micro"
    key_name = "key1"

    tags = {
    Name = "boundary-target"
  }
  }


# Nomad
output "Nomad_Private_IP_Address" {
  value = aws_instance.nomad-dev.private_ip
}

output "Nomad_Public_IP_Address" {
  value = aws_instance.nomad-dev.public_ip
}

# Vault
output "Vault_Private_IP_Address" {
  value = aws_instance.vault-dev.private_ip
}

output "Vault_Public_IP_Address" {
  value = aws_instance.vault-dev.public_ip
}

#Boundary
output "Boundary_Private_IP_Address" {
  value = aws_instance.boundary_target.private_ip
}

output "Boundary_Public_IP_Address" {
  value = aws_instance.boundary_target.public_ip
}