provider "aws" {
  region  = var.region
  profile = var.aws_profile
}


module "network" {
  source = "./module/network"
}

module "security-grp" {
  source = "./module/asg"
  vpc_id = module.network.vpc_id
}

module "iam_role" {
  source = "./module/iam"
}

module "opendap_ecr" {
  source   = "./module/ecr"
  ecr_name = "am-ghrc-hyrax"
}

module "opendap_ecs" {
  source       = "./module/ecs"
  cluster_name = "ghrc_opendap"
}

module "opendap_task" {
  source             = "./module/task"
  execution_role_arn = module.iam_role.ecsTaskExcutionRole_arn
  task_role_arn      = module.iam_role.ecs_task_assume_arn
  repository_url     = module.opendap_ecr.sls-opendap-ecr-url.repository_url
  opendap_bucket = var.opendap_bucket
}

module "alb" {
  source         = "./module/load_balancer"
  vpc_id         = module.network.vpc_id
  subnets_pub_id = flatten(module.network.service_subnet_public_ids)
  alb_sec_grp_id = [module.security-grp.security_group_elb_id]
  res_depends_on = module.network.service_subnet_public_ids
}

module "opendap_service" {
  source              = "./module/service"
  service_subnet_ids  = flatten(module.network.service_subnet_private_ids)
  security_group_ids  = [module.security-grp.security_group_ecs_task_id]
  cluster_name        = module.opendap_ecs.ecs_name
  task_definition_arn = module.opendap_task.task_arn
  target_group_arn    = module.alb.elb_id
  new_target_group_arn = module.alb.new_target_grp
  container_name      = module.opendap_task.container_name
  res_depends_on      = module.alb.front_end
}

module "logs" {
  source = "./module/cloudwatch"
}