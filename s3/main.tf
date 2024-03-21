resource "aws_s3_bucket" "bucket" {
  
  bucket = var.bucket_name
  force_destroy = var.s3_force_destroy
  
  tags = {
    Name        = "${var.bucket_name}-${var.environment}"
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.s3_oac.json
}
