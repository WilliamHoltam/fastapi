provider "aws" {
  region = "us-east-2"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "fastapi-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
}
