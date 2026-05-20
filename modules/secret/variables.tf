variable "name" {
  description = "Name of the Secrets Manager secret."
  type        = string
}

variable "secret_string" {
  description = "Initial lab secret value."
  type        = string
  sensitive   = true
}

variable "secret_string_version" {
  description = "Version number for the write-only secret string."
  type        = number
}

variable "recovery_window_in_days" {
  description = "Secrets Manager recovery window in days."
  type        = number
}
