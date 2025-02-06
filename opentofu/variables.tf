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
