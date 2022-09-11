locals {
  # lambda_name = "${local.prefix}-movies-api"
  env_vars = {
    REGION     = data.aws_region.current.name
    TABLE_NAME = var.table_name
    # For the instrumentation handler to invoke your real handler, we need this value
    NEW_RELIC_LAMBDA_HANDLER = var.handler
    NEW_RELIC_ACCOUNT_ID     = var.newrelic_account_id
    # Enable NR Lambda extension if the telemetry data are ingested via lambda extension
    NEW_RELIC_LAMBDA_EXTENSION_ENABLED = true
    # Enable Distributed tracing for in-depth monitoring of transactions in lambda (Optional)
    NEW_RELIC_DISTRIBUTED_TRACING_ENABLED  = true
    NEW_RELIC_EXTENSION_SEND_FUNCTION_LOGS = true
    # Enable honemcomb monitoring
    LIBHONEY_DATASET = var.function_name
    LIBHONEY_API_KEY = var.honeycomb_apikey
  }
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSXrayFullAccess"]
  # lambda_src_file_path = "../${path.root}/src/${var.lambda_src_file_name}.py"
  # lambda_zip_file_path = "../${path.root}/src/${var.lambda_src_file_name}.zip"
  # reqs_file_path       = "../${path.root}/src/requirements.txt"
  # packages_file_path   = "../${path.root}/packages/packages.zip"

  lambda_function_handler = var.wrapper_handler != null ? var.wrapper_handler : var.handler

}
