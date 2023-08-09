locals {
  lambda_handler      = format("%s.%s", var.app_script, var.handler_function)
  iam_for_lambda      = format("iam_%s", var.lambda_name)
  trust_policy_file   = "trust-policy.json"
  logging_policy      = format("logging_policy_%s", var.lambda_name)
  logging_policy_file = "logging-policy.json"
  requirements_txt    = format("%s/requirements.txt", var.src)
  s3_key              = format("%s_src_code.zip", var.lambda_name)
}

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = <<EOT
        cd ${var.src};
        python -m venv .venv;
        ./.venv/scripts/activate;
        pip install -r requirements.txt -t .;
        ./.venv/scripts/deactivate;
      EOT

    interpreter = ["pwsh", "-Command"]
  }

  # Only re-run if the dependencies have changed since the 
  # last deployment
  triggers = {
    dependencies_versions = filemd5(local.requirements_txt)
  }
}

# Create an archive form the Lambda source code,
# filtering out unneeded files.
data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.src
  output_path = format("%s_tmp.zip", var.src)

  excludes = [
    ".venv"
  ]

  # This is necessary, since archive_file is now a
  # `data` source and not a `resource` anymore.
  # Use `depends_on` to wait for the "install dependencies"
  # task to be completed.
  depends_on = [null_resource.install_dependencies]
}

data "local_file" "trust_policy" {
  filename = local.trust_policy_file
}

data "local_file" "logging_policy" {
  filename = local.logging_policy_file
}

# Create an IAM execution role for the Lambda function
resource "aws_iam_role" "iam_for_lambda" {
  name               = local.iam_for_lambda
  assume_role_policy = data.local_file.trust_policy.content
}

resource "aws_iam_policy" "policy" {
  name   = local.logging_policy
  policy = data.local_file.logging_policy.content
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.policy.arn
}

# upload zipped source code to s3
resource "aws_s3_object" "object" {
  bucket = var.s3_bucket
  key    = local.s3_key
  source = data.archive_file.source.output_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  # NOTE: we need this to trigger updates when the value changes. 
  # Otherwise, the files in s3 will not get updated
  etag = filemd5(data.archive_file.source.output_path)
}

# Deploy the Lambda function to AWS
resource "aws_lambda_function" "lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  s3_bucket     = aws_s3_object.object.bucket
  s3_key        = aws_s3_object.object.key
  function_name = var.lambda_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = local.lambda_handler

  source_code_hash = data.archive_file.source.output_base64sha256

  runtime = var.python_runtime
}

# Expose a public URL
resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.lambda.function_name
  authorization_type = "NONE"
}