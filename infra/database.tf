terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "~> 3.73.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_budgets_budget" "dibby-budget" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "0.0"
  limit_unit        = "GBP"
  time_unit         = "MONTHLY"
  time_period_start = "2022-01-21_00:01"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"
  name                 = "dibby-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "dibby-subnet" {
  name       = "dibby-subnet"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Dibby"
  }
}

resource "aws_db_instance" "dibby" {
  identifier             = "dibby"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "dibby"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.education.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}