resource "aws_apigatewayv2_domain_name" "api" {
  count       = var.root_dns_domain_name != null ? 1 : 0
  domain_name = local.api_domain_name

  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  dynamic "mutual_tls_authentication" {
    for_each = length(keys(var.mutual_tls_authentication)) == 0 ? [] : [var.mutual_tls_authentication]

    content {
      truststore_uri     = mutual_tls_authentication.value.truststore_uri
      truststore_version = try(mutual_tls_authentication.value.truststore_version, null)
    }
  }
}

resource "aws_route53_record" "api" {
  count   = var.root_dns_domain_name != null ? 1 : 0
  name    = aws_apigatewayv2_domain_name.api[0].domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.main[0].zone_id

  alias {
    name                   = aws_apigatewayv2_domain_name.api[0].domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.api[0].domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

