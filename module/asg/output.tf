output "security_group_elb_id" {
  value = aws_security_group.ecs-security-group-elb.id
}

output "security_group_ecs_task_id" {
  value = aws_security_group.ecs_tasks.id
}