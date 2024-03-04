resource "aws_lb" "lb" {
  name               = var.name
  subnets            = coalesce(data.aws_subnets.this.ids)
  security_groups    = var.lb_security_groups
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  idle_timeout       = var.lb_idle_timeout
}

resource "aws_lb_target_group" "tg" {
  name        = var.name
  port        = var.tg_port
  target_type = var.target_type
  protocol    = var.tg_protocol
  vpc_id      = coalesce(data.aws_vpc.this.id, aws_default_vpc.default.id)


  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  health_check {
    healthy_threshold   = var.lb_healthy_threshold
    unhealthy_threshold = var.lb_unhealthy_threshold
    interval            = var.lb_interval
    timeout             = var.lb_timeout
  }

  depends_on = [aws_lb.lb]
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.lb_default_action_type
    target_group_arn = aws_lb_target_group.tg.arn
  }

  depends_on = [aws_lb_target_group.tg]

}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "${data.aws_region.current.name}a"
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "${data.aws_region.current.name}b"
}

locals {
  default_vpc_subs = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
}