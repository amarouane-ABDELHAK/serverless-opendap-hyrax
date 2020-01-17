output "task_arn" {
  value = aws_ecs_task_definition.sls-ghrc-opendap-td.arn
}

output "container_name" {
  value = var.task_family_name
}