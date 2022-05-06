# Default Variables 

# For project specific variables use _variables.tf

variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "aws_role_external_id" {
  type        = string
  description = "TF_VAR env var from github org secrets"
  sensitive   = true
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "service_version" {
  type    = string
  default = "0.0.0"
}

variable "service_group" {
  type    = string
  default = "main"
}

variable "service" {
  type    = string
  default = "tfm-project-template"
}

variable "client" {
  type = string
}

variable "github_org" {
  type    = string
  default = "indigo-tangerine"
}

variable "github_actions_session_name" {
  type    = string
  default = "GitHubActions"
}
