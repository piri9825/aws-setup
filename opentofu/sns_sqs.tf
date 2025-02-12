resource "aws_sns_topic" "ice_cot_sns_push" {
  name = var.ice_cot_sns_push
}

resource "aws_sqs_queue" "ice_cot_sqs" {
  name                      = var.ice_cot_sqs
  message_retention_seconds = 3600
}

resource "aws_sqs_queue_policy" "ice_cot_sqs_queue_policy" {
  queue_url = aws_sqs_queue.ice_cot_sqs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "SQS:SendMessage"
      Resource  = aws_sqs_queue.ice_cot_sqs.arn
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.ice_cot_sns_push.arn
        }
      }
    }]
  })
}

resource "aws_sns_topic_subscription" "sns_sqs_subscription" {
  topic_arn = aws_sns_topic.ice_cot_sns_push.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.ice_cot_sqs.arn
}
