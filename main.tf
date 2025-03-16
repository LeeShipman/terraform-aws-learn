terraform {
  required_version = ">= v1.11.1"
  backend "s3" {
    bucket = "myapp-terraformbucket"
    key = "myapp/state.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs            = [var.avail_zone]
  public_subnets = [var.subnet_cidr_block]

  public_subnet_tags = {
    name = "${var.env_prefix}-subnet-1"
  }
  tags = {
    name = "${var.env_prefix}-vpc"
  }
}

module "my-app-webserver" {
  source              = "./modules/webserver"
  my_ip               = var.my_ip
  vpc_id              = module.vpc.vpc_id
  env_prefix          = var.env_prefix
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  avail_zone          = var.avail_zone
  image_name          = var.image_name
  ami_architecture    = var.ami_architecture
  subnet_id           = module.vpc.public_subnets[0]

}

