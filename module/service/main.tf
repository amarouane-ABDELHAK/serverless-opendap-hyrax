resource "aws_ecs_service" "main" {
  name            = var.container_name
  cluster         = var.cluster_name
  task_definition = var.task_definition_arn
  desired_count   = "1"
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = var.container_name
    container_port = 8080
  }
  load_balancer {
    target_group_arn = var.new_target_group_arn
    container_name = var.container_name
    container_port = 5000
  }
  network_configuration {
    subnets = var.service_subnet_ids
    security_groups = var.security_group_ids
  }
  depends_on = [var.res_depends_on]

}