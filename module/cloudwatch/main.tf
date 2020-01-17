resource "aws_cloudwatch_log_group" "myapp" {
  name              = var.cloudwatch_log_grp_name
  retention_in_days = 30
  tags = {
    Name = var.tag_name
  }
}