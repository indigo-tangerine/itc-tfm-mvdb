locals {
  lambda_name     = var.lambda_name == null ? "${var.stage}-${var.service}" : var.lambda_name
  api_domain_name = "${var.api_dns_hostname}.${var.stage}.${var.root_dns_domain_name}"

  access_log_settings = var.api_stage_access_log_settings_format == null ? {
    requestId = "$context.requestId"
    identity = {
      ip     = "$context.identity.sourceIp"
      caller = "$context.identity.caller"
      user   = "$context.identity.user"
    }
    requestTime      = "$context.requestTime"
    requestTimeEpoch = "$context.requestTimeEpoch"
    httpMethod       = "$context.httpMethod"
    resourcePath     = "$context.resourcePath"
    status           = "$context.status"
    protocol         = "$context.protocol"
    responseLength   = "$context.responseLength"
  } : var.api_stage_access_log_settings_format
}
