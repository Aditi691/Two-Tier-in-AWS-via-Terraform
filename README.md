# Two-Tier AWS Architecture with Terraform

This project provisions a basic two-tier web application infrastructure on AWS using Terraform. It creates a VPC, public and private subnets, an Application Load Balancer (ALB), an EC2 Auto Scaling Group, and an Amazon RDS MySQL database.

## Architecture Overview

The infrastructure follows a standard two-tier model:

- Tier 1: Web layer
  - Public subnets
  - ALB
  - EC2 instances in an Auto Scaling Group
- Tier 2: Data layer
  - Private subnets
  - RDS MySQL instance

### Network Layout

- VPC CIDR: `10.0.0.0/16`
- Public subnets: `10.0.1.0/24`, `10.0.2.0/24`
- Private subnets: `10.0.11.0/24`, `10.0.12.0/24`
- ALB is placed in the public subnets
- RDS is placed in the private subnets

## Resources Included

- `aws_vpc.myvpc`
- `aws_subnet.public1` and `aws_subnet.public2`
- `aws_subnet.private1` and `aws_subnet.private2`
- `aws_db_subnet_group.db-subnets`
- `aws_launch_template.template`
- `aws_autoscaling_group.asg`
- `aws_alb.test-alb`
- `aws_alb_target_group.tg`
- `aws_alb_listener.albl`
- `aws_db_instance.db`
- Security groups for ALB, EC2, and database traffic

## Project Files

- `provider.tf` – AWS provider configuration
- `vpc.tf` – VPC definition
- `subnets.tf` – Public/private subnet creation
- `security.tf` – Security group rules
- `instances.tf` – Launch template and Auto Scaling Group
- `alb.tf` – ALB, target group, and listener
- `rds.tf` – RDS instance configuration
- `variables.tf` – Database credentials and configurable values

## Prerequisites

Before deploying, ensure the following:

- Terraform is installed
- AWS CLI is configured with valid credentials
- An EC2 key pair named `aws-login-us1` exists in the region or use any key that exists in the region.


## Deployment Steps

Run the following commands in the project directory:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

After deployment, check the ALB DNS name in the AWS console and access the application through the load balancer.

## Important Notes

- The ALB listens on port `80` and forwards traffic to the target group.
- EC2 instances are configured to run an application on port `8000`.
- RDS is placed in private subnets and is only accessible through the EC2 security group.
- The database username and password are currently stored in `variables.tf`; for production workloads, use a secure secret management strategy.

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

This is a simple, practical AWS architecture example that can be extended with application deployment, monitoring, IAM policies, and CI/CD automation.
