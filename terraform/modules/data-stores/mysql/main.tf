resource "aws_db_instance" "example" {
  identifier_prefix   = var.name
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
