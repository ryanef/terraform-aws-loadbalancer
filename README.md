# AWS LOADBALANCER

This module is intended to be used with the VPC module [https://registry.terraform.io/modules/ryanef/vpc/aws/latest](https://registry.terraform.io/modules/ryanef/vpc/aws/latest).

The defaults on this are for an Application Load Balancer that would sit infront of an ECS Service but it's easily customized for other uses. The default security group has ingress/egress for all public traffic. When making an ECS Service you can create a security group to only accept traffic from this loadbalancer.

Support for using an account's default VPC was removed.

## QUICK START

```bash
module "vpc" {
  source  = "ryanef/vpc/aws"
  version = "1.2.3"
  vpc_name = "MyCoolVPC"
}

module "loadbalancer" {
  source  = "ryanef/loadbalancer/aws"
  version = "1.1.8"
  # insert the 2 required variables here

  vpc_name = "MyCoolVPC"

  target_group = 
    default = {
        frontend={
        name        = "frontend"
        port        = 80
        target_type = "ip"
        protocol    = "-1"
        vpc_id      = "${module.vpc.vpc_id}"
        
        enabled =true
        healthy_threshold   = 5
        unhealthy_threshold = 2
        interval            = 30
        timeout             = 3
    }
      backend={
        name        = "backend"
        port        = 5000
        target_type = "ip"
        protocol    = "-1"
        vpc_id      = "${module.vpc.vpc_id}"
        
        enabled =true
        healthy_threshold   = 5
        unhealthy_threshold = 2
        interval            = 30
        timeout             = 3
    }
}
```

## Required inputs

`target_group` is meant to be overriden when you create ECS Services. You can see exactly how it's used in the ECS Services module when multiple services are launched. The default above shows a target group that forwards traffic to frontend containers that have ports open on 80.

`vpc_name` and `environment` variables are used for naming the loadbalancer, listeners, target groups and also add tags in a `vpc_name-dev-[resource]` format.

## Changing Defaults

Many of the `variables.tf` entries are for changing configuration on the Target Groups and Listeners. [AWS Docs](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html) can be helpful if you want to change some of the defaults.

**variable "target_type"**

By default this is **"ip"** since it was intended to be used with ECS Fargate.

**variable "lb_default_action_type"**

This is for the loadbalancer's listener configuration. Default is "forward".
