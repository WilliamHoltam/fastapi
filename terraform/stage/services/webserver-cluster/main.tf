terraform {
  backend "s3" {
    bucket = "fastapi-state"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
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
  source = "github.com/WilliamHoltam/fastapi_tf_modules//services//webserver-cluster?ref=v0.0.1"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "fastapi-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}
