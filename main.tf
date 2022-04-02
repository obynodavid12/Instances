terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }
    random = {
      source = "hashicorp/aws"
      version = ">=3.0.0"
    }     
  }
  
  cloud {
  organization = "Dataalgebra-Cloud"

    workspaces {
      name = "AWS-DataalgebraCloud"
    }
  }
}

## Provider us-east-2
#provider "aws" {
#  region = "us-east-2"
#  profile = "default"
#}




module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "ec2" {
  source     = "./modules/ec2"
  namespace  = var.namespace
  githubtoken = var.GITHUBTOKEN
  githuborg   = var.GITHUBORG
  repo        = var.repo
  aws_default_region = var.AWS_DEFAULT_REGION
  aws_secret_access_key = var.AWS_SECRET_ACCESS_KEY
  aws_access_key_id  = var.AWS_ACCESS_KEY_ID
  vpc        = module.networking.vpc
  sg_pub_id  = module.networking.sg_pub_id
  sg_priv_id = module.networking.sg_priv_id
  key_name   = module.ssh-key.key_name

}
