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
    google = {
      source = "hashicorp/google"

    }
  }
}
#
provider "aws" {
  region = "us-west-2"
}
provider "google" {
  project = "hc-9cb6a2a268e34ff8bf3653639eb"
  region  = "asia-southeast2"
  zone    = "asia-southeast2-a"
}

resource "aws_instance" "nomad-dev" {
  ami           = "ami-023e152801ee4846a" #Deploy Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  key_name      = "key1"

  tags = {
    Name = "nomad-dev"
  }
}

resource "aws_instance" "vault-dev" {
  ami           = "ami-023e152801ee4846a" #Deploy Amazon Linux 2023 AMI
  instance_type = "t2.micro"
  key_name      = "key1"

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

resource "google_compute_network" "vpc_network" {
  name = "rio-terraform-network"
}

resource "google_compute_instance" "vault_gcp" {

  name         = "rio-terraform-instance1"
  machine_type = "e2-medium"
  zone         = "asia-southeast2-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
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

# Vault GCP
output "Vault_GCP_Private_IP_Address" {
  value = google_compute_instance.vault_gcp.network_interface.0.network_ip
}