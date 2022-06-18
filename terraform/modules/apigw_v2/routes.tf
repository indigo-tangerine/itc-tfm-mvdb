# default
resource "aws_apigatewayv2_route" "default" {
  for_each = var.api_integrations

  api_id               = aws_apigatewayv2_api.main.id
  route_key            = each.key
  target               = "integrations/${aws_apigatewayv2_integration.main[each.key].id}"
  authorization_scopes = try(jsondecode(each.value.authorization_scopes), null)
  authorization_type   = try(each.value.authorization_type, null)
  authorizer_id        = try(each.value.authorizer_id, null)
}

# resource "aws_apigatewayv2_route_response" "default" {
#   api_id             = aws_apigatewayv2_api.main.id
#   route_id           = aws_apigatewayv2_route.default.id
#   route_response_key = aws_apigatewayv2_route.default.route_key
# }
