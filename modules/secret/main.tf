resource "aws_secretsmanager_secret" "this" {
  name                    = var.name
  description             = "Lab secret monitored by CloudTrail, CloudWatch, and SNS."
  recovery_window_in_days = var.recovery_window_in_days
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id                = aws_secretsmanager_secret.this.id
  secret_string_wo         = var.secret_string
  secret_string_wo_version = var.secret_string_version
}
