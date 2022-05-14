# Usage

<!--- BEGIN_TF_DOCS --->
### Requirements

No requirements.

### Providers

No providers.

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | terraform-aws-modules/dynamodb-table/aws | 1.2.2 |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | n/a | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | n/a | `string` | `"year"` | no |
| <a name="input_hash_key_type"></a> [hash\_key\_type](#input\_hash\_key\_type) | n/a | `string` | `"N"` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | n/a | `string` | `"title"` | no |
| <a name="input_range_key_type"></a> [range\_key\_type](#input\_range\_key\_type) | n/a | `string` | `"S"` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | n/a | `any` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | n/a |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | n/a |

<!--- END_TF_DOCS --->

