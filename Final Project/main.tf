module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.private_subnet_id
  key_name  = "test1"

}

module "sqs" {
  source = "./modules/sqs"

  incoming_queue_name   = var.incoming_queue_name
  completion_queue_name = var.completion_queue_name

}

module "s3" {
  source = "./modules/s3"

  bucket_name = "myzapp-bucket"
}

module "alb" {
  source   = "./modules/alb"
  name     = "my-load-balancer"
  internal = false
  vpc_id   = module.vpc.vpc_id
  subnets  = [module.vpc.public_subnet_id]



  target_group_name            = "main-target-group"
  target_group_port            = 80
  target_group_protocol        = "HTTP"
  python_target_group_name     = "python-target-group"
  python_target_group_port     = 5000
  python_target_group_protocol = "HTTP"
}

module "secrets_manager" {
  source = "./modules/secrets_manager"

  secret_name          = "app-secret"
  incoming_queue_url   = module.sqs.incoming_queue_url
  completion_queue_url = module.sqs.completion_queue_url
  s3_bucket_name       = module.s3.s3_bucket_name
}
