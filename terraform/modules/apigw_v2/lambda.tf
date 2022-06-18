resource "aws_lambda_permission" "lambda_permission" {
  action        = "lambda:InvokeFunction"
  function_name = local.lambda_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_apigatewayv2_api.main.execution_arn}/$default/*"
  # source_arn = aws_apigatewayv2_api.main.execution_arn
}
