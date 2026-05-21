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
- Permission to create Secrets Manager, CloudTrail, CloudWatch Logs, S3, and IAM resources through Step 2.

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

## Deploy Step 2

Step 2 adds a single-region CloudTrail trail, an S3 log bucket, and a CloudWatch Logs group for later metric filtering.

```sh
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```

## Test Step 2

```sh
aws cloudtrail get-trail-status \
  --region "$(terraform output -raw aws_region)" \
  --name "$(terraform output -raw cloudtrail_name)"

aws logs describe-log-groups \
  --region "$(terraform output -raw aws_region)" \
  --log-group-name-prefix "$(terraform output -raw cloudtrail_log_group_name)"
```

## Test Step 3

Read the secret after CloudTrail is enabled:

```sh
aws secretsmanager get-secret-value \
  --region "$(terraform output -raw aws_region)" \
  --secret-id "$(terraform output -raw secret_name)" \
  --query SecretString \
  --output text
```

Then confirm CloudTrail recorded the access event:

```sh
aws cloudtrail lookup-events \
  --region "$(terraform output -raw aws_region)" \
  --lookup-attributes AttributeKey=EventName,AttributeValue=GetSecretValue \
  --max-results 5 \
  --query 'Events[].{EventName:EventName,EventTime:EventTime,Source:EventSource,User:Username,Resource:Resources[0].ResourceName}'
```

CloudTrail can take a few minutes to show new events. The event should have `EventName` set to `GetSecretValue` and `Source` set to `secretsmanager.amazonaws.com`.

## Deploy Step 4

Step 4 adds a CloudWatch Logs metric filter that matches `GetSecretValue` events for the monitored secret.

```sh
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
```

## Test Step 4

Confirm the metric filter exists:

```sh
aws logs describe-metric-filters \
  --region "$(terraform output -raw aws_region)" \
  --log-group-name "$(terraform output -raw cloudtrail_log_group_name)" \
  --filter-name-prefix "$(terraform output -raw secret_access_metric_filter_name)"
```

Test the filter pattern with a sample CloudTrail event:

```sh
aws logs test-metric-filter \
  --filter-pattern "$(terraform output -raw secret_access_filter_pattern)" \
  --log-event-messages "{\"eventSource\":\"secretsmanager.amazonaws.com\",\"eventName\":\"GetSecretValue\",\"requestParameters\":{\"secretId\":\"$(terraform output -raw secret_name)\"}}"
```
