output "IAM_ROLE_ARN" {
  value = aws_iam_role.ghactions.arn
}

output "CLOUDFRONT_DISTRO_ID" {
  value = module.cloudfront.cloudfront_id
}

output "CLOUDFRONT_DOMAIN" {
  value = "https://${module.cloudfront.cloudfront_domain}"
}

output "S3_BUCKET" {
  value = module.s3.bucket_name
}

output "S3_REGIONAL_DOMAIN" {
  value = module.s3.bucket_regional_domain
}

output "AWS_REGION" {
  value = var.aws_region
}