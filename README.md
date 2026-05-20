# AWS Secret Access Monitoring with Terraform

This project builds a security monitoring system for AWS Secrets Manager access events, one Terraform step at a time.

## Step Progress

- Step 1: Create a secret in AWS Secrets Manager.
- Step 2: Enable CloudTrail to record AWS account activity.
- Step 3: Test CloudTrail by accessing the secret.
- Step 4: Add a CloudWatch Logs metric filter for secret access logs.
- Step 5: Add a CloudWatch alarm and SNS email alert.
- Step 6: Test and troubleshoot the full monitoring system.

## Prerequisites

- Terraform `>= 1.11`.
- AWS CLI authenticated to the target account.
- Permission to create Secrets Manager resources for Step 1.

## Configure Step 1

Create a local tfvars file:

```sh
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and replace `secret_string` with a lab-only value. Keep `terraform.tfvars` local; it is ignored by git.

## Deploy Step 1

```sh
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```

## Test Step 1

```sh
aws secretsmanager describe-secret \
  --region "$(terraform output -raw aws_region)" \
  --secret-id "$(terraform output -raw secret_name)"

aws secretsmanager get-secret-value \
  --region "$(terraform output -raw aws_region)" \
  --secret-id "$(terraform output -raw secret_name)" \
  --query SecretString \
  --output text
```
