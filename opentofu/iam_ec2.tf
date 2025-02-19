data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ec2_user_data_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DescribeInstanceAttribute",
      "ecs:RegisterContainerInstance",
      "ecs:RegisterTaskDefinition",
      "ecs:DeregisterTaskDefinition",
      "ecs:RunTask",
      "ecs:StopTask",
      "ecs:UpdateService",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:List*",
      "ecs:Describe*",
      "dynamodb:Scan",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "ec2_instance_role" {
  name               = "ec2-instance-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role_policy" "ec2_user_data_policy_attachment" {
  role   = aws_iam_role.ec2_instance_role.name
  policy = data.aws_iam_policy_document.ec2_user_data_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_container_service_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"

}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ecs-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}