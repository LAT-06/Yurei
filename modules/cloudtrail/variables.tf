variable "project_name" {
  description = "Short lowercase project name used as a resource prefix."
  type        = string
}

variable "cloudwatch_log_retention_days" {
  description = "Retention period for CloudTrail logs delivered to CloudWatch Logs."
  type        = number
}

variable "s3_log_retention_days" {
  description = "Number of days to retain CloudTrail log objects in S3."
  type        = number
}
