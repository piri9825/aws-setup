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
