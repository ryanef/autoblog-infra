data "aws_region" "current" {}
data "aws_canonical_user_id" "this" {
}
data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "s3_oac" {

  statement {
    
    condition {
      test = "StringEquals"
      variable= "AWS:SourceArn"
      values = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_id}"]
    }

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    effect = "Allow"

    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}