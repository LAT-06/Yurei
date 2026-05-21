output "alarm_name" {
  description = "Name of the CloudWatch alarm."
  value       = aws_cloudwatch_metric_alarm.secret_access.alarm_name
}

output "alarm_arn" {
  description = "ARN of the CloudWatch alarm."
  value       = aws_cloudwatch_metric_alarm.secret_access.arn
}

output "topic_arn" {
  description = "ARN of the SNS topic."
  value       = aws_sns_topic.secret_access.arn
}

output "subscription_arn" {
  description = "ARN of the SNS email subscription."
  value       = aws_sns_topic_subscription.email.arn
}
