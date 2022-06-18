
resource "aws_lambda_function" "main" {
  filename      = var.lambda_zip_file_path
  function_name = var.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.handler
  timeout       = var.timeout

  source_code_hash = filebase64sha256(var.lambda_zip_file_path)

  tracing_config {
    mode = var.tracing_mode
  }

  depends_on = [
    # data.null_data_source.lambda_file,
    # data.archive_file.lambda_archive,
    # aws_cloudwatch_log_group.main.dead_letter_config,
    aws_iam_role_policy_attachment.lambda_policy_attach
  ]

  runtime = var.runtime
  layers  = var.lambda_layer_arns

  environment {
    variables = local.env_vars
  }
}

# data "null_data_source" "lambda_file" {
#   inputs = {
#     filename = var.lambda_src_file_name
#   }
# }


# data "null_data_source" "lambda_archive" {
#   depends_on = [data.null_data_source.lambda_file]
#   inputs = {
#     filename = local.lambda_zip_file_path
#   }
# }

# data "archive_file" "lambda_archive" {
#   # count = var.create ? 1 : 0
#   # depends_on  = ["data.null_data_source.lambda_archive"]
#   type        = "zip"
#   output_path = local.lambda_zip_file_path
#   source_file = local.lambda_src_file_path
# }


