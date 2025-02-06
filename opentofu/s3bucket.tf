resource "aws_s3_bucket" "buckettesting" {
  bucket = "piribuckettesting"

  tags = {
    Name = "buckettesting"
  }
}