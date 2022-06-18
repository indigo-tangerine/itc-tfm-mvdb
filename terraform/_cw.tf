#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "api_gw_account" {
  name              = "/aws/apigateway/${var.service}/${var.stage}"
  retention_in_days = var.cloudwatch_logs_retention_in_days[var.stage]
}
