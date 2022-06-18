variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
  default     = "lambda_handler"
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = "python3.8"

  #  validation {
  #    condition     = can(var.create && contains(["nodejs10.x", "nodejs12.x", "java8", "java11", "python2.7", " python3.6", "python3.7", "python3.8", "dotnetcore2.1", "dotnetcore3.1", "go1.x", "ruby2.5", "ruby2.7", "provided"], var.runtime))
  #    error_message = "The runtime value must be one of supported by AWS Lambda."
  #  }
}


variable "cloudwatch_logs_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = 3
}

variable "tracing_mode" {
  description = "Tracing mode of the Lambda Function. Valid value can be either PassThrough or Active."
  type        = string
  default     = "Active"
}

variable "attach_cloudwatch_logs_policy" {
  description = "Controls whether CloudWatch Logs policy should be added to IAM role for Lambda Function"
  type        = bool
  default     = true
}


variable "attach_tracing_policy" {
  description = "Controls whether X-Ray tracing policy should be added to IAM role for Lambda Function"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of IAM role to use for Lambda Function"
  type        = string
  default     = null
}

variable "package_type" {
  description = "The Lambda deployment package type. Valid options: Zip or Image"
  type        = string
  default     = "Zip"
}

variable "allowed_triggers" {
  description = "Map of allowed triggers to create Lambda permissions"
  type        = map(any)
  default     = {}
}

variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = any # string | list(string | map(any))
  default     = null
}

variable "table_name" {
  type        = string
  description = "Dynamodb table name"
  default     = null
}

variable "table_arn" {
  type        = string
  description = "Dynamodb table arn"
  default     = null
}

# variable "lambda_src_file_name" {
#   type    = string
#   default = "mvdb"
# }

variable "timeout" {
  type        = number
  description = "Amount of time your Lambda Function has to run in seconds"
  default     = 15
}

# variable "xray_layer_arn" {
#   type        = string
#   description = "X-ray lambda layer arn"
# }

variable "lambda_zip_file_path" {
  type = string
}

variable "lambda_layer_arns" {
  type        = list(any)
  description = "Lambda layer arns"
  default     = []
}

variable "managed_policy_arns" {
  type        = list(any)
  description = "Custom IAM policy arns"
  default     = []
}

# New Relic
variable "wrapper_handler" {
  type    = string
  default = null
}

variable "newrelic_account_id" {
  type    = string
  default = "3519964"
}

