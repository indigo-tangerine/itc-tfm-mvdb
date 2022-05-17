locals {
  default_tags = {
    service_version = var.service_version == "<service-version>" ? "0.0.0" : var.service_version
    stage           = var.stage
    service_group   = var.service_group
    service         = var.service
    iac             = "terraform"
  }

  aws_provider_assume_role_arn = "arn:aws:iam::${var.aws_account_id}:role/${local.cicd_automation_role_name}"

  cicd_automation_role_name = "${var.client}-cicd-automation"

  xray_packages_zip_file_path = "../artifacts/xray-packages.zip"
  lambda_src_zip_file_path    = "../artifacts/${var.service}.zip"
}
