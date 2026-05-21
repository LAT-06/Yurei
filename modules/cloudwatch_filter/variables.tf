variable "project_name" {
  description = "Short lowercase project name used as a resource prefix."
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch Logs group that receives CloudTrail events."
  type        = string
}

variable "secret_name" {
  description = "Name of the monitored Secrets Manager secret."
  type        = string
}

variable "secret_arn" {
  description = "ARN of the monitored Secrets Manager secret."
  type        = string
}
