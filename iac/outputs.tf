output "version" {
  value       = aws_lambda_function.lambda.version
  description = "AWS Version for this lambda"
}

output "invoke_arn" {
  value       = aws_lambda_function.lambda.invoke_arn
  description = "ARN required for invoking this lambda"
}

output "public_url" {
  value       = aws_lambda_function_url.lambda_url.function_url
  description = "pubic url for invoking this lambda"
}
output "zip" {
  value = data.archive_file.source.output_path
}
