variable "vpc_id" {
  type    = string
  default = null
}

variable "deregistration_delay"{
  type = number
  default = 60
}
variable "environment" {
  type = string
  default = "dev"
}
variable "egress_cidr_ipv4"{
   default = "0.0.0.0/0"
   type = string
}
variable "egress_from_port"{
    default = null

}
variable "egress_ip_protocol"{
    default = "-1"
    type = string

}
variable "egress_to_port"{
  default = null
}
variable "egress_referenced_security_group_id"{
  default = null
}

variable "ingress_cidr_ipv4"{
  default = "0.0.0.0/0"
  type = string
}
variable "ingress_from_port"{
  default = null
}
variable "ingress_ip_protocol"{
  default = "-1"
  type = string
}
variable "ingress_to_port"{
  default = null
}
variable "ingress_referenced_security_group_id"{
  default = null
}

variable "lb_type" {
  type    = string
  default = "application"
}

variable "health_check_enabled" {
  type = bool
  default = true
}

variable "lb_idle_timeout" {
  type    = number
  default = 30
}

variable "lb_healthy_threshold" {
  type    = number
  default = 5
}

variable "lb_internal" {
  type    = bool
  default = false
}

variable "lb_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "lb_interval" {
  type    = number
  default = 30
}
variable "lb_timeout" {
  type    = number
  default = 3
}

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "lb_default_action_type" {
  type    = string
  default = "forward"
}

variable "public_subnets" {
  default = [""]
  description = "Use this when bringing in subnets from VPC module"
}

variable "tg_attachment_port" {
  type    = number
  default = 80
}

variable "target_group" {
  type = map


  # default = {
  #       frontend={
  #       name        = "first"
  #       port        = 80
  #       target_type = "ip"
  #       protocol    = "-1"
  #       vpc_id      = ""
        
  #       enabled =true
  #       healthy_threshold   = 5
  #       unhealthy_threshold = 2
  #       interval            = 30
  #       timeout             = 3
     
  #   }
  }


variable "target_type" {
  default = "ip"
  type = string
  description = "ip is for Fargate. Change to instance for EC2."
}


variable "tg_protocol" {
  type    = string
  default = "HTTP"
  description = "target group protocol"
}

variable "tg_port" {
  type    = number
  default = 80
  description = "target group port"
}


variable "vpc_name" {
  type = string
}

