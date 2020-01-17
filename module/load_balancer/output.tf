output "elb_id" {
  value = aws_alb_target_group.app.id
}

output "front_end" {
  value = aws_alb_listener.front_end
}

output "dns" {
  value = aws_alb.main.dns_name
}