# AWS LOADBALANCER

This module was intended to be used with my VPC and ECS Fargate modules but it can work alone by using an account's default VPC.

In `variables.tf`, set **use_default_vpc** to *false* if you plan to import my VPC module.

## Changing Defaults

Many of the `variables.tf` entries are for changing configuration on the Target Groups and Listeners. [AWS Docs](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html) can be helpful if you want to change some of the defaults.

**variable "lb_security_groups"**

This module doesn't make any security groups for the loadbalancer but is a placeholder for the modules that do make them. They can be added in the module import block through this variable.

**variable "target_type"**

By default this is **"ip"** since it was intended to be used with ECS Fargate. **instance** could used as well.

**variable "lb_default_action_type"**

This is for the loadbalancer's listener configuration. Default is "forward".

**variable "subnets"**

If **use_default_vpc** is *true* it will try to use public subnets from account's default VPC. If set to false the subnets will have to come from the VPC module.

**variable "lt_instance_type"**

This and anything else with an **lt__** prefix is for Launch Templates and so is the **user_data_file_name** that points to user-data.sh which for now is just a simple nginx installation for servers running Debian based OS.