
module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = "${var.stage}-${var.service}"
}
