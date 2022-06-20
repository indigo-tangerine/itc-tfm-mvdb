# Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

No requirements.

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_api_mapping.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_domain_name.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_apigatewayv2_integration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_lambda_permission.lambda_permission](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_route53_record.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_access_log_arn"></a> [api\_access\_log\_arn](#input\_api\_access\_log\_arn) | API cloudwatch log group arn | `string` | `null` | no |
| <a name="input_api_description"></a> [api\_description](#input\_api\_description) | (Optional) The description of the API | `string` | `null` | no |
| <a name="input_api_disable_execute_api_endpoint"></a> [api\_disable\_execute\_api\_endpoint](#input\_api\_disable\_execute\_api\_endpoint) | (Optional) Whether clients can invoke the API by using the default execute-api endpoint | `bool` | `true` | no |
| <a name="input_api_dns_hostname"></a> [api\_dns\_hostname](#input\_api\_dns\_hostname) | (Option) The dns name of the API | `string` | `"http-api"` | no |
| <a name="input_api_integrations"></a> [api\_integrations](#input\_api\_integrations) | Map of API integrations to create | `map(any)` | <pre>{<br>  "GET": {<br>    "authorization_scopes": null,<br>    "authorization_type": null,<br>    "authorizer_id": null,<br>    "connection_type": "INTERNET",<br>    "description": null,<br>    "integration_type": "AWS_PROXY",<br>    "payload_format_version": "1.0",<br>    "response_parameters": null,<br>    "timeout_milliseconds": 50,<br>    "tls_config": null,<br>    "uri": null<br>  }<br>}</pre> | no |
| <a name="input_api_name"></a> [api\_name](#input\_api\_name) | (Required) The name of the API | `string` | n/a | yes |
| <a name="input_api_protocol_type"></a> [api\_protocol\_type](#input\_api\_protocol\_type) | (Required) The API protocol | `string` | `"HTTP"` | no |
| <a name="input_api_route_key"></a> [api\_route\_key](#input\_api\_route\_key) | (Optional) Specifies any route key. | `string` | `null` | no |
| <a name="input_api_stage_access_log_settings_format"></a> [api\_stage\_access\_log\_settings\_format](#input\_api\_stage\_access\_log\_settings\_format) | (Optional) Settings for logging access in this stage | `map(any)` | `null` | no |
| <a name="input_api_stage_auto_deploy"></a> [api\_stage\_auto\_deploy](#input\_api\_stage\_auto\_deploy) | (Optional) Whether updates to an API automatically trigger a new deployment | `bool` | `true` | no |
| <a name="input_api_stage_data_trace_enabled"></a> [api\_stage\_data\_trace\_enabled](#input\_api\_stage\_data\_trace\_enabled) | (Optional) Whether data trace logging is enabled for the route | `bool` | `null` | no |
| <a name="input_api_stage_enable_metrics"></a> [api\_stage\_enable\_metrics](#input\_api\_stage\_enable\_metrics) | (Optional) Whether detailed metrics enabled | `bool` | `false` | no |
| <a name="input_api_stage_env_vars"></a> [api\_stage\_env\_vars](#input\_api\_stage\_env\_vars) | (Optional) stage environment variables | `map(any)` | `{}` | no |
| <a name="input_api_stage_logging_level"></a> [api\_stage\_logging\_level](#input\_api\_stage\_logging\_level) | (Optional) The logging level for the default route. Affects the log entries pushed to Amazon CloudWatch Logs. Valid values: ERROR, INFO, OFF | `string` | `null` | no |
| <a name="input_api_target"></a> [api\_target](#input\_api\_target) | (Optional) Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP\_PROXY or AWS\_PROXY, respectively. | `string` | `"AWS_PROXY"` | no |
| <a name="input_api_version"></a> [api\_version](#input\_api\_version) | (Optional) A version identifier for the API | `string` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | `null` | no |
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | CORS configuration settings | `map(any)` | `null` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Lambda function name | `string` | `null` | no |
| <a name="input_mutual_tls_authentication"></a> [mutual\_tls\_authentication](#input\_mutual\_tls\_authentication) | MTLS certificate settings | `map(any)` | `{}` | no |
| <a name="input_root_dns_domain_name"></a> [root\_dns\_domain\_name](#input\_root\_dns\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | Service name | `string` | `"mvdb"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage | `string` | `"dev"` | no |
| <a name="input_throttling_burst_limit"></a> [throttling\_burst\_limit](#input\_throttling\_burst\_limit) | (Optional) The throttling burst limit for the default route | `string` | `100` | no |
| <a name="input_throttling_rate_limit"></a> [throttling\_rate\_limit](#input\_throttling\_rate\_limit) | (Optional) The throttling rate limit for the default route | `string` | `100` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | n/a |

<!--- END_TF_DOCS --->

