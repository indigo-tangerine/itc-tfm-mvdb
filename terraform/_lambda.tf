#tfsec:ignore:aws-cloudwatch-log-group-customer-key
module "lambda" {
  source = "./modules/lambda"

  function_name  = "movies-db"
  table_name     = module.movie_db.table_name
  table_arn      = module.movie_db.table_arn
  runtime        = var.runtime
  xray_layer_arn = aws_lambda_layer_version.xray.arn
}
