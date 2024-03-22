# AWS LOADBALANCER

This module is intended to be used with the VPC module [https://registry.terraform.io/modules/ryanef/vpc/aws/latest](https://registry.terraform.io/modules/ryanef/vpc/aws/latest).

The defaults on this are for an Application Load Balancer that would sit infront of an ECS Service. The default security group has ingress/egress for all public traffic. When making an ECS Service you can create a security group to only accept traffic from this loadbalancer.

Support for using an account's default VPC was removed.

## Required inputs

Import the VPC module and it will export `vpc_name` and `vpc_id`, `public_subnets` as outputs.

`vpc_name` and `environment` variables are used for naming the loadbalancer, listeners, target groups and also add tags in a `vpc_name-dev-[resource]` format.

`public_subnets` The VPC module gives 2 public subnets by default.

## Changing Defaults

Many of the `variables.tf` entries are for changing configuration on the Target Groups and Listeners. [AWS Docs](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html) can be helpful if you want to change some of the defaults.

**variable "target_type"**

By default this is **"ip"** since it was intended to be used with ECS Fargate.

**variable "lb_default_action_type"**

This is for the loadbalancer's listener configuration. Default is "forward".
