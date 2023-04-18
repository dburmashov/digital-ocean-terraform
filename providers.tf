terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.27.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}


provider "digitalocean" {
  token = var.digital_ocean_token
}

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
