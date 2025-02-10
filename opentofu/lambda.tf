data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_s3_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.datastore.id}/*"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = var.iam_lambda
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "lambda_s3_policy_attachment" {
  role   = aws_iam_role.iam_for_lambda.name
  policy = data.aws_iam_policy_document.lambda_s3_policy.json
}

resource "aws_lambda_function" "ice_cot_lambda" {
  function_name = var.ice_cot_lambda
  role          = aws_iam_role.iam_for_lambda.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  image_config {
    command = ["pipelines.${var.ice_cot_lambda}.handler"]
  }
  timeout = 30
}
