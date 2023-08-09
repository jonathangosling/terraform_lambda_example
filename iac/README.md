<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.7.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.7.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/lambda_function) | resource |
| [aws_lambda_function_url.lambda_url](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/lambda_function_url) | resource |
| [aws_s3_object.object](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/s3_object) | resource |
| [null_resource.install_dependencies](https://registry.terraform.io/providers/hashicorp/null/3.2.1/docs/resources/resource) | resource |
| [archive_file.source](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [local_file.logging_policy](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.trust_policy](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_script"></a> [app\_script](#input\_app\_script) | name of the python script containing the execution function | `string` | `"main"` | no |
| <a name="input_handler_function"></a> [handler\_function](#input\_handler\_function) | name of the execution function | `string` | `"lambda_handler"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | lambda name | `string` | n/a | yes |
| <a name="input_python_runtime"></a> [python\_runtime](#input\_python\_runtime) | Required python runtime | `string` | `"python3.10"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | s3 bucket to load zipped source code to | `string` | `"lambda-zip-archives-terraform"` | no |
| <a name="input_src"></a> [src](#input\_src) | path to the source code | `string` | `"../lambda_src"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | ARN required for invoking this lambda |
| <a name="output_public_url"></a> [public\_url](#output\_public\_url) | pubic url for invoking this lambda |
| <a name="output_version"></a> [version](#output\_version) | AWS Version for this lambda |
<!-- END_TF_DOCS -->