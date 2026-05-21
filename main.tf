module "secret" {
  source = "./modules/secret"

  name                    = var.secret_name
  secret_string           = var.secret_string
  secret_string_version   = var.secret_string_version
  recovery_window_in_days = var.secret_recovery_window_in_days
}

module "cloudtrail" {
  source = "./modules/cloudtrail"

  project_name                  = var.project_name
  cloudwatch_log_retention_days = var.cloudwatch_log_retention_days
  s3_log_retention_days         = var.s3_log_retention_days
}
