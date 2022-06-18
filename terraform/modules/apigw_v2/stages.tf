resource "aws_apigatewayv2_stage" "main" {
  api_id          = aws_apigatewayv2_api.main.id
  name            = "$default"
  auto_deploy     = var.api_stage_auto_deploy
  stage_variables = var.api_stage_env_vars

  dynamic "access_log_settings" {
    for_each = toset([var.api_access_log_arn])
    content {
      destination_arn = var.api_access_log_arn
      format          = jsonencode(local.access_log_settings)
    }
  }

  default_route_settings {
    detailed_metrics_enabled = try(var.api_stage_enable_metrics, false)
    logging_level            = try(var.api_stage_logging_level, null)
    data_trace_enabled       = try(var.api_stage_data_trace_enabled, false)
    throttling_burst_limit   = try(var.throttling_burst_limit, null)
    throttling_rate_limit    = try(var.throttling_rate_limit, null)
  }
}

