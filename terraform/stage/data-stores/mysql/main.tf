terraform {
  backend "s3" {
    bucket = "fastapi-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "fastapi-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  db_name             = "example_database"
  username            = "admin"
  skip_final_snapshot = true
  password            = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["mysql-master-password-stage"]
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "mysql-master-password-stage"
}
