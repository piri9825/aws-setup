variable "project_name" {
  description = "Project name"
  type        = string
}

variable "state_bucket" {
  description = "S3 Bucket for .tfstate file"
  type        = string
}

variable "state_key" {
  description = "Key for S3 Bucket for .tfstate file"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "profile" {
  description = "Profile"
  type        = string
}

variable "datastore" {
  description = "Datastore"
  type        = string
}

variable "ecr_repo" {
  description = "ECR Repo"
  type        = string
}

variable "pull_ice_cot_lambda" {
  description = "Pull ICE COT Lambda Function Name"
  type        = string
}

variable "iam_lambda" {
  description = "IAM for Lambda Name"
  type        = string
}

variable "ice_cot_sns_push" {
  description = "ICE COT SNS Push"
  type        = string
}

variable "ice_cot_sqs" {
  description = "ICE COT SQS"
  type        = string
}

variable "process_ice_cot_lambda" {
  description = "Process ICE COT Lambda Function Name"
  type        = string
}

variable "aws-setup-dynamodb" {
  description = "DynamoDB"
  type        = string
}