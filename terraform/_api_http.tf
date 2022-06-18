module "http_api_gw" {
  source = "./modules/apigw_v2"

  api_name             = "${var.stage}-${var.service}"
  api_dns_hostname     = local.http_api_dns_hostname
  api_integrations     = local.api_http_integrations
  api_access_log_arn   = aws_cloudwatch_log_group.api_gw_account.arn
  root_dns_domain_name = var.root_dns_domain_name
  certificate_arn      = data.aws_acm_certificate.wildcard.arn
  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }
}

locals {
  api_http_integrations = {
    "GET /" = {
      integration_type                 = "AWS_PROXY"
      connection_type                  = "INTERNET"
      uri                              = module.lambda.arn
      payload_format_version           = "1.0"
      authorization_scopes             = jsonencode(aws_cognito_resource_server.mvdb.scope_identifiers)
      authorization_type               = "JWT"
      authorizer_id                    = aws_apigatewayv2_authorizer.cognito.id
      tls_config_server_name_to_verify = local.http_api_dns_name
    }
    "$default" = {
      uri                              = module.lambda.arn
      tls_config_server_name_to_verify = local.http_api_dns_name
      response_parameters = jsonencode([
        {
          status_code = 500
          mappings = {
            "append:header.header1" = "$context.requestId"
            "overwrite:statuscode"  = "403"
          }
        },
        {
          status_code = 404
          mappings = {
            "append:header.error" = "$stageVariables.environmentId"
          }
        }
      ])
    }

  }
}

resource "aws_apigatewayv2_authorizer" "cognito" {
  api_id           = module.http_api_gw.api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "${local.http_api_dns_hostname}-cognito"

  jwt_configuration {
    audience = [aws_cognito_user_pool_client.mvdb.id]
    issuer   = "https://${jsondecode(data.aws_secretsmanager_secret_version.cognito.secret_string)["endpoint"]}"
  }
}

data "aws_secretsmanager_secret" "cognito" {
  name = "${var.client}-cognito"
}

data "aws_secretsmanager_secret_version" "cognito" {
  secret_id = data.aws_secretsmanager_secret.cognito.id
}
