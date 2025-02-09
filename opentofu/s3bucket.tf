resource "aws_s3_bucket" "datastore" {
  bucket = "${var.project_name}-${var.datastore}"
}

resource "aws_s3_object" "ice_cot_folder" {
  bucket = aws_s3_bucket.datastore.id
  key    = "ice_cot/"
}