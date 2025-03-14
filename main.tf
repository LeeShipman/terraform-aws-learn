provider "aws" {
  region = "eu-west-2"
}



resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source                 = "./modules/subnet"
  subnet_cidr_block      = var.subnet_cidr_block
  avail_zone             = var.avail_zone
  env_prefix             = var.env_prefix
  vpc_id                 = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id

}

module "my-app-webserver" {
  source              = "./modules/webserver"
  my_ip               = var.my_ip
  vpc_id              = aws_vpc.myapp-vpc.id
  env_prefix          = var.env_prefix
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  avail_zone          = var.avail_zone
  image_name          = var.image_name
  ami_architecture    = var.ami_architecture
  subnet_id           = module.myapp-subnet.subnet.id

}

