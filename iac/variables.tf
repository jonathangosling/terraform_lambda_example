variable "python_runtime" {
  type        = string
  default     = "python3.10"
  description = "Required python runtime"
}

variable "lambda_name" {
  type        = string
  description = "lambda name"
}

variable "lambda_source" {
  type        = string
  default     = "../src"
  description = "relative path for the lambda source code"
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
