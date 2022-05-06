# Terraform - Description Goes Here

## Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>4.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>4.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account ID | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | n/a | yes |
| <a name="input_aws_role_external_id"></a> [aws\_role\_external\_id](#input\_aws\_role\_external\_id) | TF\_VAR env var from github org secrets | `string` | n/a | yes |
| <a name="input_client"></a> [client](#input\_client) | n/a | `string` | n/a | yes |
| <a name="input_github_actions_session_name"></a> [github\_actions\_session\_name](#input\_github\_actions\_session\_name) | n/a | `string` | `"GitHubActions"` | no |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | n/a | `string` | `"indigo-tangerine"` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `"tfm-project-template"` | no |
| <a name="input_service_group"></a> [service\_group](#input\_service\_group) | n/a | `string` | `"main"` | no |
| <a name="input_service_version"></a> [service\_version](#input\_service\_version) | n/a | `string` | `"0.0.0"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | n/a | `string` | `"dev"` | no |

### Outputs

No outputs.

<!--- END_TF_DOCS --->
