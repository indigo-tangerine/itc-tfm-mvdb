#tfsec:ignore:aws-cloudwatch-log-group-customer-key
module "lambda" {
  source = "./modules/lambda"

  function_name = "${var.stage}-${var.service}"
  table_name    = module.movie_db.table_name
  table_arn     = module.movie_db.table_arn
  runtime       = var.runtime
  lambda_layer_arns = [
    aws_lambda_layer_version.xray.arn,
    local.apm_lambda_layer
  ]
  lambda_zip_file_path              = local.lambda_src_zip_file_path
  handler                           = "${var.service}.lambda_handler"
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days[var.stage]
  managed_policy_arns               = ["arn:aws:iam::${var.aws_account_id}:policy/NewRelic-ViewLicenseKey-${var.aws_region}"]
  wrapper_handler                   = local.apm_handler
  honeycomb_apikey                  = local.honeycomb_apikey
}


locals {
  apm              = "newrelic" # "honeycomb"
  apm_lambda_layer = local.apm == "newrelic" ? "arn:aws:lambda:${var.aws_region}:451483290750:layer:NewRelicPython39:20" : "arn:aws:lambda:${var.aws_region}:702835727665:layer:honeycomb-lambda-extension-x86_64:10"
  apm_handler      = local.apm == "newrelic" ? "newrelic_lambda_wrapper.handler" : null
}
