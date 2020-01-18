resource "aws_cloudwatch_log_group" "myapp" {
  name              = var.cloudwatch_log_grp_name
  retention_in_days = 30
  tags = {
    Name = var.tag_name
  }
}

resource "aws_cloudwatch_log_stream" "cb_log_stream" {
  name           = "cb-log-stream"
  log_group_name = aws_cloudwatch_log_group.myapp.name
}