output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_regional_domain" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}