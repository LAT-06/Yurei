data "aws_region" "current" {}

output "aws_region" {
  description = "AWS region where the stack is deployed."
  value       = data.aws_region.current.region
}

output "secret_name" {
  description = "Name of the monitored Secrets Manager secret."
  value       = module.secret.name
}

output "secret_arn" {
  description = "ARN of the monitored Secrets Manager secret."
  value       = module.secret.arn
}
