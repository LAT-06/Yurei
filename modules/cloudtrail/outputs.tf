output "trail_name" {
  description = "Name of the CloudTrail trail."
  value       = aws_cloudtrail.this.name
}

output "trail_arn" {
  description = "ARN of the CloudTrail trail."
  value       = aws_cloudtrail.this.arn
}

output "log_bucket_name" {
  description = "S3 bucket where CloudTrail stores log files."
  value       = aws_s3_bucket.logs.bucket
}

output "log_group_name" {
  description = "CloudWatch Logs group that receives CloudTrail events."
  value       = aws_cloudwatch_log_group.trail.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch Logs group that receives CloudTrail events."
  value       = aws_cloudwatch_log_group.trail.arn
}
