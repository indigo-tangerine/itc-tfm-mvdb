# General
variable "stage" {
  type        = string
  description = "Stage"
  default     = "dev"
}

variable "service" {
  type        = string
  description = "Service name"
  default     = "mvdb"
}

variable "lambda_name" {
  type        = string
  description = "Lambda function name"
  default     = null
}

variable "root_dns_domain_name" {
  type    = string
  default = null
}

variable "certificate_arn" {
  type    = string
  default = null
}

# API Gateway
variable "api_name" {
  type        = string
  description = "(Required) The name of the API"
}

variable "api_dns_hostname" {
  type        = string
  description = "(Option) The dns name of the API"
  default     = "http-api"
}

variable "api_description" {
  type        = string
  description = "(Optional) The description of the API"
  default     = null
}

variable "api_protocol_type" {
  type        = string
  description = "(Required) The API protocol"
  default     = "HTTP"
}

variable "api_disable_execute_api_endpoint" {
  type        = bool
  default     = false
  description = "(Optional) Whether clients can invoke the API by using the default execute-api endpoint"
}

variable "api_route_key" {
  type        = string
  description = "(Optional) Specifies any route key."
  default     = null
}

variable "api_target" {
  type        = string
  description = "(Optional) Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively."
  default     = "AWS_PROXY"
}

variable "api_version" {
  type        = string
  description = "(Optional) A version identifier for the API"
  default     = null
}

variable "cors_configuration" {
  type        = map(any)
  description = "CORS configuration settings"
  default     = null
}

variable "mutual_tls_authentication" {
  type        = map(any)
  description = "MTLS certificate settings"
  default     = {}
}

# API Gatewy Integration
variable "api_integrations" {
  type        = map(any)
  description = "Map of API integrations to create"
  default = {
    GET = {
      description            = null
      integration_type       = "AWS_PROXY"
      connection_type        = "INTERNET"
      uri                    = null
      payload_format_version = "1.0"
      response_parameters    = null
      timeout_milliseconds   = 50
      tls_config             = null
      authorization_scopes   = null
      authorization_type     = null
      authorizer_id          = null
    }
  }
}

# API Stage
variable "api_access_log_arn" {
  type        = string
  description = "API cloudwatch log group arn"
  default     = null
}

variable "api_stage_access_log_settings_format" {
  type        = map(any)
  description = "(Optional) Settings for logging access in this stage"
  default     = null
}

variable "api_stage_auto_deploy" {
  type        = bool
  description = "(Optional) Whether updates to an API automatically trigger a new deployment"
  default     = true
}

variable "api_stage_env_vars" {
  type        = map(any)
  description = "(Optional) stage environment variables"
  default     = {}
}

# default stage route settings
variable "api_stage_data_trace_enabled" {
  type        = bool
  description = "(Optional) Whether data trace logging is enabled for the route"
  default     = null
}

variable "throttling_burst_limit" {
  type        = string
  description = "(Optional) The throttling burst limit for the default route"
  default     = 100
}

variable "throttling_rate_limit" {
  type        = string
  description = "(Optional) The throttling rate limit for the default route"
  default     = 100
}

variable "api_stage_enable_metrics" {
  type        = bool
  description = "(Optional) Whether detailed metrics enabled"
  default     = false
}

variable "api_stage_logging_level" {
  type        = string
  description = "(Optional) The logging level for the default route. Affects the log entries pushed to Amazon CloudWatch Logs. Valid values: ERROR, INFO, OFF"
  default     = null
}
