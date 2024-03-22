output "lb_id" {
  value = aws_lb.lb.id
}
output "lb_arn" {
  value = aws_lb.lb.arn
}

output "lb_dns_name" {
  value = aws_lb.lb.dns_name
}

output "security_group_id" {
  value = aws_security_group.allow_public.id
}
output "tg_id" {
  value = aws_lb_target_group.tg.id
}

output "tg_arn" {
  value = aws_lb_target_group.tg.arn
}

