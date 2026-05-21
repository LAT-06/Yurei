data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition

  topic_name = "${var.project_name}-secret-access-alerts"
  alarm_name = "${var.project_name}-secret-access"
}

resource "aws_sns_topic" "secret_access" {
  name = local.topic_name
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.secret_access.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "secret_access" {
  alarm_name          = local.alarm_name
  alarm_description   = "Triggers when the monitored Secrets Manager secret is read."
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = var.metric_name
  namespace           = var.metric_namespace
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.secret_access.arn]
}

data "aws_iam_policy_document" "sns_topic" {
  statement {
    sid = "AllowAccountTopicManagement"

    principals {
      type        = "AWS"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
    }

    actions = [
      "SNS:AddPermission",
      "SNS:DeleteTopic",
      "SNS:GetTopicAttributes",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:Subscribe"
    ]

    resources = [aws_sns_topic.secret_access.arn]
  }

  statement {
    sid = "AllowCloudWatchAlarmPublish"

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.secret_access.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudwatch_metric_alarm.secret_access.arn]
    }
  }
}

resource "aws_sns_topic_policy" "secret_access" {
  arn    = aws_sns_topic.secret_access.arn
  policy = data.aws_iam_policy_document.sns_topic.json
}
