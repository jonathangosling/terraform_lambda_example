variable "python_runtime" {
  type        = string
  default     = "python3.10"
  description = "Required python runtime"
}

variable "lambda_name" {
  type        = string
  description = "lambda name"
}

variable "src" {
  type        = string
  default     = "../lambda_src"
  description = "path to the source code"
}

variable "app_script" {
  type        = string
  default     = "main"
  description = "name of the python script containing the execution function"
}

variable "handler_function" {
  type        = string
  default     = "lambda_handler"
  description = "name of the execution function"
}

variable "s3_bucket" {
  type        = string
  default     = "lambda-zip-archives-terraform"
  description = "s3 bucket to load zipped source code to"
}
