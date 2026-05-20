module "secret" {
  source = "./modules/secret"

  name                    = var.secret_name
  secret_string           = var.secret_string
  secret_string_version   = var.secret_string_version
  recovery_window_in_days = var.secret_recovery_window_in_days
}
