# Example/Template Terraform to Generate an AWS Lambda Function From Source Code

AWS lambda functions require all python dependencies to be uploaded along with the source code/application all within one zipped folder. This is different to GCP and Azure, which will install dependencies from a requirements.txt file. This can be quite a cumbersome task when wanting to make minor changes to the application.

Previously, I devised a solution by using a docker image. Lambda is able to build it's containerised environments from a docker image published to AWS ECR. Then, using CodeBuild, the entire process to update a lambda function with code/environment changes can be made as easy as committing (individual) changes to a github repo. See [this](https://github.com/jonathangosling/WebAPI) github repo, where I use this methodology.

Since, I have learnt Terraform. This is an infrastructure as code (IaC) tool making setting up all sorts of infrastructure pieces easily repeatable. It has a strong use case whenever you want to create multiple of the same piece (i.e. deploying mulitple VMs with the same configuration) since you only need to write the Terraform once and can then create and destroy multiple pieces with ease, avoiding monotomous, repetitve, cumbersome manual set up. It will also ensure that all pieces are made to the same spec, removing human error. It also has strong use cases for exactly the problem I faced before - the overly time consuming task of manually zipping up environements and deploying to AWS Lambda.

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

- When you create a lambda function in the console, it will give you the choice of execution role (create new with basic lambda permissions, use existing, create new from a policy template). In terraform, we have to specify the role arn number, i.e. we need to create (or fetch the arn of an existing) iam role.  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
- Alos, when creating in the console, an execution role with permissions to upload to CloudWatch logs is created by default. In terraform, we have to do this ourselves. Need to ceate policy and attach it to the iam role: https://stackoverflow.com/questions/58285508/correct-terraform-syntax-for-adding-permissions-to-aws-lambda https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment.html https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
- Add publicly accessible url. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_url

- tests directory - some unit tests for json and tf files. run pytest -s in root directory.

- use null resource to run commands to zip up dependencies

- add trigger to pip install to only execute if the contents of requirements.txt has changed. Can do this using filemd5, the file version of md5 https://www.bitslovers.com/terraform-null-resource/

- will only let you load zip archives of a certain size unless you load from s3