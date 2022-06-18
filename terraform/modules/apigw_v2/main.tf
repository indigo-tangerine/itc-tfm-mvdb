resource "aws_apigatewayv2_api" "main" {
  name                         = var.api_name
  description                  = try(var.api_description, var.api_name)
  protocol_type                = var.api_protocol_type
  disable_execute_api_endpoint = var.api_disable_execute_api_endpoint
  route_key                    = var.api_route_key
  version                      = var.api_version

  dynamic "cors_configuration" {
    for_each = length(keys(var.cors_configuration)) == 0 ? [] : [var.cors_configuration]

    content {
      allow_credentials = try(cors_configuration.value.allow_credentials, null)
      allow_headers     = try(cors_configuration.value.allow_headers, null)
      allow_methods     = try(cors_configuration.value.allow_methods, null)
      allow_origins     = try(cors_configuration.value.allow_origins, null)
      expose_headers    = try(cors_configuration.value.expose_headers, null)
      max_age           = try(cors_configuration.value.max_age, null)
    }
  }
}

resource "aws_apigatewayv2_integration" "main" {
  for_each = var.api_integrations

  api_id                 = aws_apigatewayv2_api.main.id
  integration_method     = try(each.value.integration_method, "POST")
  integration_type       = try(each.value.integration_type, "AWS_PROXY")
  integration_subtype    = try(each.value.integration_subtype, null)
  connection_type        = try(each.value.connection_type, "INTERNET")
  description            = try(each.value.description, null)
  integration_uri        = try(each.value.uri, null)
  payload_format_version = try(each.value.payload_format_version, "1.0")
  timeout_milliseconds   = try(each.value.timeout_milliseconds, null)


  # dynamic "response_parameters" {
  #   for_each = try(jsondecode(each.value.response_parameters), {})
  #   content {
  #     status_code = each.value.response_parameters.status_code
  #     mappings = {
  #       jsondecode(each.value.response_parameters.mappings.key) = jsondecode(each.value.response_parameters.mappings.value)
  #     }
  #   }
  # }

  dynamic "response_parameters" {
    for_each = flatten([try(jsondecode(each.value["response_parameters"]), each.value["response_parameters"], [])])

    content {
      status_code = response_parameters.value["status_code"]
      mappings    = response_parameters.value["mappings"]
    }
  }

  dynamic "tls_config" {
    for_each = try([each.value.tls_config_server_name_to_verify], [])
    content {
      server_name_to_verify = each.value.tls_config_server_name_to_verify
    }
  }
}

resource "aws_apigatewayv2_api_mapping" "main" {
  count       = var.root_dns_domain_name != null ? 1 : 0
  api_id      = aws_apigatewayv2_api.main.id
  domain_name = aws_apigatewayv2_domain_name.api[0].id
  stage       = aws_apigatewayv2_stage.main.id
}
