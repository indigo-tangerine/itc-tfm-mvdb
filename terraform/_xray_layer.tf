resource "aws_lambda_layer_version" "xray" {
  filename   = local.xray_packages_zip_file_path
  layer_name = "xray-sdk"

  compatible_runtimes = [var.runtime]
  source_code_hash    = filebase64sha256(local.xray_packages_zip_file_path)
}

