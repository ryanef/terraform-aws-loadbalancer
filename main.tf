resource "aws_lb" "lb" {
  name               = var.vpc_name
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.allow_public.id]
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  idle_timeout       = var.lb_idle_timeout

  tags = {
    Name = "${var.vpc_name}-${var.environment}-public-lb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = var.vpc_name
  port        = var.tg_port
  target_type = var.target_type
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id


  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  health_check {
    enabled = true
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

resource "aws_security_group" "allow_public" {
  name        = "public traffic for loadbalancer"
  description = "public traffic for loadbalancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-${var.environment}-public-lb"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  security_group_id = aws_security_group.allow_public.id
  cidr_ipv4 =         var.ingress_cidr_ipv4
  from_port         = var.ingress_from_port
  ip_protocol       = var.ingress_ip_protocol
  to_port           = var.ingress_to_port
  referenced_security_group_id = var.ingress_referenced_security_group_id
}
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.allow_public.id
  cidr_ipv4 =         var.egress_cidr_ipv4
  from_port         = var.egress_from_port
  ip_protocol       = var.egress_ip_protocol
  to_port           = var.egress_to_port
  referenced_security_group_id = var.ingress_referenced_security_group_id
}
