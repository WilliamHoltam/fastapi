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
}

provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "github.com/WilliamHoltam/fastapi_tf_modules//data-stores//mysql?ref=v0.0.1"
  name   = "mysql-stage"
}
