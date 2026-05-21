locals {
  metric_namespace = "SecurityMonitoring/${var.project_name}"
  metric_name      = "SecretAccessCount"
  filter_name      = "${var.project_name}-secret-access"

  filter_pattern = trimspace(<<-PATTERN
    { ($.eventSource = "secretsmanager.amazonaws.com") && ($.eventName = "GetSecretValue") && (($.requestParameters.secretId = "${var.secret_name}") || ($.requestParameters.secretId = "${var.secret_arn}")) }
  PATTERN
  )
}

resource "aws_cloudwatch_log_metric_filter" "secret_access" {
  name           = local.filter_name
  log_group_name = var.log_group_name
  pattern        = local.filter_pattern

  metric_transformation {
    name      = local.metric_name
    namespace = local.metric_namespace
    value     = "1"
  }
}
