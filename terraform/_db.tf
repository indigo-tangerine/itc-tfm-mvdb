
#tfsec:ignore:aws-dynamodb-enable-recovery tfsec:ignore:aws-dynamodb-enable-at-rest-encryption



module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = "${var.stage}-${var.service}"
}
