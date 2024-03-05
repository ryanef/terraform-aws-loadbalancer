variable "vpc_id" {
  type    = string
  default = null
}

variable "use_default_vpc" {
  default = true
}

variable "desired_capacity" {
  type    = number
  default = 1
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


variable "instance_count" {
  default = 1
}

variable "lb_security_groups" {
  default = null
}

variable "lb_type" {
  type    = string
  default = "application"
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

variable "lt_key_name" {
  type    = string
  default = "ltkey"
    description = "launch template key"
}

variable "lt_name" {
  type    = string
  default = "tf-lt"
  description = "launch template name"
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

variable "lt_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 1
}

variable "name" {
  type    = string
  default = "MyLB"
}

variable "subnets" {
  default = [""]
  description = "Use this when bringing in subnets from VPC module"
}

variable "tg_attachment_port" {
  type    = number
  default = 80
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

variable "user_data_file_name" {
  type    = string
  default = "user-data.sh"
}

variable "vpc_name" {
  default = "TFE_CONTROLLER"
}

variable "vpc_tag" {
  type = string
  default = "TFE_CONTROLLER"
}