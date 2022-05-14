output "table_name" {
  value = module.dynamodb.dynamodb_table_id
}

output "table_arn" {
  value = module.dynamodb.dynamodb_table_arn
}
