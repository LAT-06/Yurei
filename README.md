# AWS Secret Access Monitoring with Terraform

This project deploys a single-region security monitoring system for AWS Secrets Manager access events.

It creates:

- A Secrets Manager secret.
- A CloudTrail trail that records management events to S3 and CloudWatch Logs.
- A CloudWatch Logs metric filter and CloudWatch alarm that notify SNS when the secret is read.
- A second EventBridge rule that sends a separate SNS notification for the same `GetSecretValue` event.

## Prerequisites

- Terraform `>= 1.11`.
- AWS CLI authenticated to the target account.
- Permission to create Secrets Manager, CloudTrail, CloudWatch, EventBridge, SNS, S3, and IAM resources.

