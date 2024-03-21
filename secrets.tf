
resource "aws_ssm_parameter" "s3" {
  name  = "/autoblog/S3_BUCKET"
  type  = "SecureString"
  value = module.s3.bucket_name
  overwrite = true
  
}

resource "aws_ssm_parameter" "cf" {
  name  = "/autoblog/CLOUDFRONT_ID"
  type  = "SecureString"
  value = module.cloudfront.cloudfront_id
  overwrite = true
}

resource "aws_ssm_parameter" "role" {
  name  = "/autoblog/IAM_ROLE"
  type  = "SecureString"
  value = aws_iam_role.ghactions.arn
  overwrite = true
}
resource "aws_ssm_parameter" "region" {
  name  = "/autoblog/AWS_REGION"
  type  = "SecureString"
  value = aws_iam_role.ghactions.arn
  overwrite = true
}


