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

  for_each = var.target_group
  name        = each.value.name
  port        = each.value.port
  target_type = each.value.target_type
  protocol    = each.value.protocol
  vpc_id      = each.value.vpc_id
  deregistration_delay = var.deregistration_delay

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }

  health_check {
    enabled = each.value.enabled
    healthy_threshold   = each.value.healthy_threshold
    unhealthy_threshold = each.value.unhealthy_threshold
    interval            = each.value.interval
    timeout             = each.value.timeout
  }

  depends_on = [aws_lb.lb]
}

resource "aws_lb_listener" "lb_listener" {
  for_each = aws_lb_target_group.tg
  load_balancer_arn = aws_lb.lb.arn
  port              = each.value.port
  protocol          = "HTTP"

  default_action {
    type             = var.lb_default_action_type
    target_group_arn = each.value.arn
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
resource "aws_vpc_security_group_ingress_rule" "vpc" {
  security_group_id = aws_security_group.allow_public.id
  cidr_ipv4 =       "${data.aws_vpc.selected.cidr_block}"
  ip_protocol       = "-1"
}
resource "aws_vpc_security_group_egress_rule" "vpc" {
  security_group_id = aws_security_group.allow_public.id
  cidr_ipv4 =        "${data.aws_vpc.selected.cidr_block}"
  ip_protocol       = "-1"

}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.allow_public.id
  cidr_ipv4 =         var.ingress_cidr_ipv4
  from_port         = var.ingress_from_port
  ip_protocol       = var.ingress_ip_protocol
  to_port           = var.ingress_to_port
  referenced_security_group_id = var.ingress_referenced_security_group_id
}
