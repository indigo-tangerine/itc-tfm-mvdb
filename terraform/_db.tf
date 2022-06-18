
#tfsec:ignore:aws-dynamodb-enable-recovery tfsec:ignore:aws-dynamodb-enable-at-rest-encryption
module "movie_db" {
  source = "./modules/dynamodb"

  table_name = "${var.stage}-${var.service}"
}
