variable "project_name" {
  description = "Short lowercase project name used as a resource prefix."
  type        = string
}

variable "alert_email" {
  description = "Email address subscribed to SNS secret access alerts."
  type        = string
}

variable "metric_namespace" {
  description = "CloudWatch metric namespace for monitored secret reads."
  type        = string
}

variable "metric_name" {
  description = "CloudWatch metric name for monitored secret reads."
  type        = string
}
