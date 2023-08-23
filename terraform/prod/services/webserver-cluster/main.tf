terraform {
  backend "s3" {
    bucket = "fastapi-state"
    key    = "prod/services/webserver-cluster/terraform.tfstate"
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

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "fastapi-state"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro" # "m4.large"
  min_size      = 2
  max_size      = 10
}
