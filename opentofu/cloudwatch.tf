resource "aws_cloudwatch_log_group" "pull_ice_cot_logs" {
  name              = "/aws/lambda/${var.pull_ice_cot_lambda}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "process_ice_cot_logs" {
  name              = "/aws/lambda/${var.process_ice_cot_lambda}"
  retention_in_days = 7
}