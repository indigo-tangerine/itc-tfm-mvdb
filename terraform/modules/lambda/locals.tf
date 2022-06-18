locals {
  # lambda_name = "${local.prefix}-movies-api"
  env_vars = {
    REGION     = data.aws_region.current.name
    TABLE_NAME = var.table_name
  }
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSXrayFullAccess"]
  # lambda_src_file_path = "../${path.root}/src/${var.lambda_src_file_name}.py"
  # lambda_zip_file_path = "../${path.root}/src/${var.lambda_src_file_name}.zip"
  # reqs_file_path       = "../${path.root}/src/requirements.txt"
  # packages_file_path   = "../${path.root}/packages/packages.zip"
}


