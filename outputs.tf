data "aws_region" "current" {}

output "aws_region" {
  description = "AWS region where the stack is deployed."
  value       = data.aws_region.current.region
}

output "secret_name" {
  description = "Name of the monitored Secrets Manager secret."
  value       = module.secret.name
}

output "secret_arn" {
  description = "ARN of the monitored Secrets Manager secret."
  value       = module.secret.arn
}

output "cloudtrail_name" {
  description = "Name of the CloudTrail trail."
  value       = module.cloudtrail.trail_name
}

output "cloudtrail_log_bucket" {
  description = "S3 bucket where CloudTrail stores log files."
  value       = module.cloudtrail.log_bucket_name
}

output "cloudtrail_log_group_name" {
  description = "CloudWatch Logs group that receives CloudTrail events."
  value       = module.cloudtrail.log_group_name
}

output "secret_access_metric_filter_name" {
  description = "CloudWatch Logs metric filter that matches monitored secret reads."
  value       = module.secret_access_filter.filter_name
}

output "secret_access_metric_namespace" {
  description = "CloudWatch metric namespace for monitored secret reads."
  value       = module.secret_access_filter.metric_namespace
}

output "secret_access_metric_name" {
  description = "CloudWatch metric name for monitored secret reads."
  value       = module.secret_access_filter.metric_name
}

output "secret_access_filter_pattern" {
  description = "CloudWatch Logs filter pattern used to detect monitored secret reads."
  value       = module.secret_access_filter.filter_pattern
}
