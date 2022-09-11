data "aws_secretsmanager_secret" "honeycomb" {
  name = "honeycomb"
}

data "aws_secretsmanager_secret_version" "honeycomb" {
  secret_id = data.aws_secretsmanager_secret.honeycomb.id
}

locals {
  honeycomb_apikey = jsondecode(data.aws_secretsmanager_secret_version.honeycomb.secret_string)["api_key"]
}
