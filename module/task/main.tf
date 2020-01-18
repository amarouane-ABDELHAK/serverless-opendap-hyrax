data "template_file" "ghrc-opendap-task-definition" {
  template = file("./module/templates/ghrc-opendap.json.tpl")
  vars = {
    REPOSITORY_URL = var.repository_url
    TASK_FAMILY_NAME = var.task_family_name
  }

}


resource "aws_ecs_task_definition" "sls-ghrc-opendap-td" {
  container_definitions = data.template_file.ghrc-opendap-task-definition.rendered
  family = var.task_family_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
}