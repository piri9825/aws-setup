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

variable "ice_cot_lambda" {
  description = "ICE COT Lambda Function Name"
  type        = string
}

variable "iam_lambda" {
  description = "IAM for Lambda Name"
  type        = string
}