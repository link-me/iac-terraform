module "network" {
  source             = "./modules/network"
  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
  bucket_name  = "${var.project_name}-${var.environment}-bucket"
}

module "compute" {
  source           = "./modules/compute"
  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  instance_type    = var.instance_type
  allow_ssh_cidr   = var.allow_ssh_cidr
  ami_id           = var.ami_id
}