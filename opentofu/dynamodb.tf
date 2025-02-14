resource "aws_dynamodb_table" "aws-setup-dynamodb" {
  name         = "aws-setup-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "Market"
  range_key    = "Date"

  attribute {
    name = "Market"
    type = "S"
  }

  attribute {
    name = "Date"
    type = "S"
  }
}

