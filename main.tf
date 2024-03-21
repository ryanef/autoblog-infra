module "s3" {
  source = "./s3"

  bucket_name = "${var.bucket_name}-${random_integer.r.result}"
  cloudfront_id = module.cloudfront.cloudfront_id
  environment = var.environment
}

module "cloudfront" {
  source = "./cloudfront"
  
  bucket_regional_domain_name = module.s3.bucket_regional_domain
  bucket_name = module.s3.bucket_name
  environment = var.environment
}

resource "random_integer" "r" {
  min = 556
  max = 1234
}