#tfsec:ignore:aws-cloudwatch-log-group-customer-key
module "lambda" {
  source = "./modules/lambda"

  function_name = "${var.stage}-${var.service}"
  table_name    = module.movie_db.table_name
  table_arn     = module.movie_db.table_arn
  runtime       = var.runtime
  lambda_layer_arns = [
    aws_lambda_layer_version.xray.arn,
    "arn:aws:lambda:${var.aws_region}:451483290750:layer:NewRelicPython39:20"
  ]
  lambda_zip_file_path              = local.lambda_src_zip_file_path
  handler                           = "${var.service}.lambda_handler"
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days[var.stage]
  managed_policy_arns               = ["arn:aws:iam::${var.aws_account_id}:policy/NewRelic-ViewLicenseKey-${var.aws_region}"]
  wrapper_handler                   = "newrelic_lambda_wrapper.handler"
}
