# Project variables

variable "service" {
  type    = string
  default = "mvdb"
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
