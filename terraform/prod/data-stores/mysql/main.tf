terraform {
  backend "s3" {
    bucket = "fastapi-state"
    key    = "prod/data-stores/mysql/terraform.tfstate"
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
}

provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "../../../modules/data-stores/mysql"
  name   = "mysql-prod"
}
