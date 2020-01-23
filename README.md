# serverless-opendap-hyrax
Terraform module to provision OPeNDAP Hyrax serverlessly using fargate AWS service

## Requirements
* aws-cli
* terraform v12
* Docker
* Python +3.7

## How to Deploy OPeNDAP Hyrax
- change `variables.tf` variables (Note that opendap_bucket should already exist in your AWS account)
- run `terraform init`
- run `terraform apply`

The last command will output ECR URI and ALB URL. Use the ECR URI to build the container 
- run `cd opendap-app`
- run `$(aws ecr get-login --profile <your profile> --region "<your region>" --no-include-email)` 
- run `docker build -t <<ECR_URI>> .`
- run `docker push <<ECR_URI>>`

Visit ALB URL and enjoy!