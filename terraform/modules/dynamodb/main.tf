module "dynamodb" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "1.2.2"

  name      = var.table_name
  hash_key  = var.hash_key
  range_key = var.range_key

  attributes = [
    {
      name = var.hash_key
      type = var.hash_key_type
    },
    {
      name = var.range_key
      type = var.range_key_type
    }
  ]

  billing_mode = var.billing_mode
}


