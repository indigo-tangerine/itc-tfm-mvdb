// Terraform Backend
terraform {
  required_version = "~>1.0"

  backend "s3" {
    bucket         = "tfm-state-256645035107"
    region         = "eu-west-1"
    encrypt        = "true"
    dynamodb_table = "tfm-state-lock"
    ############################################
    # Update deploy env backend.tfvars file in /configuration folder with state file path and name
    ############################################
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}
