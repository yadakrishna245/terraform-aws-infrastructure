# =============================================================
# AWS Infrastructure - Multi-Tier Deployment
# Author: Yada Krishna Chaithanya
# =============================================================

module "s3_cloudfront" {
  source       = "./modules/s3-cloudfront"
  project_name = var.project_name
  environment  = var.environment
}

module "vpc_ec2" {
  source       = "./modules/vpc-ec2"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

module "rds" {
  source       = "./modules/rds"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc_ec2.vpc_id
  private_subnets = module.vpc_ec2.private_subnets
  web_sg_id    = module.vpc_ec2.web_sg_id
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
}
