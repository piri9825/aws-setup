# aws-setup
A simple data engineering project to learn how to use AWS.

## Prerequisites
- AWS Account + manually created s3 Bucket for OpenTofu backend used to store `.tfstate` file.
- AWS CLI + Setup a Profile to authenticate using an IAM Role
- Docker
- OpenTofu

## AWS Authentication
- `export AWS_PROFILE=admin-1`
- Login to AWS using `aws sso login`

## Setting up AWS
- Use OpenTofu to spin up services on AWS
- Use Docker to push images to ECR
