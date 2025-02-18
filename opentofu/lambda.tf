resource "aws_lambda_function" "pull_ice_cot_lambda" {
  function_name = var.pull_ice_cot_lambda
  role          = aws_iam_role.iam_for_lambda.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  image_config {
    command = ["pipelines.${var.pull_ice_cot_lambda}.handler"]
  }
  timeout = 30
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }

  depends_on = [aws_cloudwatch_log_group.pull_ice_cot_logs]
}

resource "aws_lambda_function" "process_ice_cot_lambda" {
  function_name = var.process_ice_cot_lambda
  role          = aws_iam_role.iam_for_lambda.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  image_config {
    command = ["pipelines.${var.process_ice_cot_lambda}.handler"]
  }
  timeout = 30
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }

  depends_on = [aws_cloudwatch_log_group.process_ice_cot_logs]
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.ice_cot_sqs.arn
  function_name    = aws_lambda_function.process_ice_cot_lambda.arn
  batch_size       = 1
}
