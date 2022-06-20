# Project variables

variable "service" {
  type    = string
  default = "mvdb"
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = "python3.9"

  #  validation {
  #    condition     = can(var.create && contains(["nodejs10.x", "nodejs12.x", "java8", "java11", "python2.7", " python3.6", "python3.7", "python3.8", "dotnetcore2.1", "dotnetcore3.1", "go1.x", "ruby2.5", "ruby2.7", "provided"], var.runtime))
  #    error_message = "The runtime value must be one of supported by AWS Lambda."
  #  }
}

variable "cloudwatch_logs_retention_in_days" {
  type        = map(any)
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default = {
    dev = 3
    acc = 10
    prd = 30
  }
}
