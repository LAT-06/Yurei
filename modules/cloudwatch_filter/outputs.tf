output "filter_name" {
  description = "Name of the CloudWatch Logs metric filter."
  value       = aws_cloudwatch_log_metric_filter.secret_access.name
}

output "filter_pattern" {
  description = "CloudWatch Logs filter pattern used to detect monitored secret reads."
  value       = local.filter_pattern
}

output "metric_namespace" {
  description = "CloudWatch metric namespace for monitored secret reads."
  value       = local.metric_namespace
}

output "metric_name" {
  description = "CloudWatch metric name for monitored secret reads."
  value       = local.metric_name
}
