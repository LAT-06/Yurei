variable "aws_region" {
  description = "AWS region where this single-region monitoring stack is deployed."
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Short lowercase name used as a prefix for AWS resources."
  type        = string
  default     = "secret-monitoring"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,29}$", var.project_name))
    error_message = "project_name must be 3-30 characters, start with a lowercase letter, and contain only lowercase letters, numbers, or hyphens."
  }
}

variable "secret_name" {
  description = "Name of the Secrets Manager secret monitored by this project."
  type        = string
  default     = "secret-monitoring/demo-secret"
}

variable "secret_string" {
  description = "Initial lab secret value. Set this only in local terraform.tfvars; do not commit it."
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.secret_string) > 0
    error_message = "secret_string must not be empty."
  }
}

variable "secret_string_version" {
  description = "Increment this number when changing secret_string because the secret value uses Terraform write-only storage."
  type        = number
  default     = 1

  validation {
    condition     = var.secret_string_version >= 1
    error_message = "secret_string_version must be 1 or greater."
  }
}

variable "secret_recovery_window_in_days" {
  description = "Secrets Manager recovery window. Use 0 for easy lab cleanup or 7-30 for production-like recovery."
  type        = number
  default     = 0

  validation {
    condition     = var.secret_recovery_window_in_days == 0 || (var.secret_recovery_window_in_days >= 7 && var.secret_recovery_window_in_days <= 30)
    error_message = "secret_recovery_window_in_days must be 0, or a value from 7 through 30."
  }
}

variable "cloudwatch_log_retention_days" {
  description = "Retention period for CloudTrail logs delivered to CloudWatch Logs."
  type        = number
  default     = 30

  validation {
    condition = contains([
      1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180,
      365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653
    ], var.cloudwatch_log_retention_days)
    error_message = "cloudwatch_log_retention_days must be a retention value supported by CloudWatch Logs."
  }
}

variable "s3_log_retention_days" {
  description = "Number of days to retain CloudTrail log objects in S3."
  type        = number
  default     = 90

  validation {
    condition     = var.s3_log_retention_days >= 1
    error_message = "s3_log_retention_days must be 1 or greater."
  }
}

variable "alert_email" {
  description = "Email address subscribed to SNS secret access alerts. Set this only in local terraform.tfvars."
  type        = string

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.alert_email))
    error_message = "alert_email must be a valid email address."
  }
}
