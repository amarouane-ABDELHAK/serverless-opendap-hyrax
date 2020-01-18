resource "aws_alb" "main" {
  name            = "tf-ecs-chat"
  subnets         = var.subnets_pub_id
  security_groups = var.alb_sec_grp_id
  depends_on = [var.res_depends_on]
}

resource "aws_alb_target_group" "app" {
  name        = "tf-ecs-chat"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "80"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "30"
    port = "8080"
    path                = "/opendap/"
    unhealthy_threshold = "2"
  }
}


resource "aws_alb_target_group" "openapp" {
  name        = "tf-ecs-baxc"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "80"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "30"
    port = "8080"
    path                = "/opendap/"
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "back_end" {
  load_balancer_arn = aws_alb.main.id
  port              = "5000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.openapp.id
    type             = "forward"
  }
}