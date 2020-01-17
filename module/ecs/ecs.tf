resource "aws_ecs_cluster" "ghrc-ecs" {
  name = var.cluster_name
}