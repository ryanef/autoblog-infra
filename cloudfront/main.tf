resource "aws_cloudfront_function" "s3redirect" {
  name    = "${var.bucket_name}-redirect"
  runtime = "cloudfront-js-2.0"
  comment = "redirect for S3 index files"
  publish = true
  code    = file("${path.root}/cloudfront-function.js")
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = var.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = var.bucket_name
  }


  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = var.default_object


  # logging_config {
  #   include_cookies = false
  #   bucket          = var.log_bucket_domain
  #   prefix          = ""
  # }

  # aliases = var.cf_aliases

  default_cache_behavior {
      function_association {
        event_type = "viewer-request"
        function_arn = aws_cloudfront_function.s3redirect.arn
      }
    allowed_methods  = var.default_cache_am
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.bucket_name

    forwarded_values {
      query_string = var.default_forwarded_values_querystring

      cookies {
        forward = var.default_cache_cookies_forward
      }
    }

    viewer_protocol_policy = var.default_viewer_protocol_policy
    min_ttl                = var.default_min_ttl
    default_ttl            = var.default_default_ttl
    max_ttl                = var.default_max_ttl
  }

  # Cache behavior with precedence 0
  # ordered_cache_behavior {
  #   path_pattern     = "/content/immutable/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   target_origin_id = var.bucket_name

  #   forwarded_values {
  #     query_string = false
  #     headers      = ["Origin"]

  #     cookies {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
  #   default_ttl            = 86400
  #   max_ttl                = 31536000
  #   compress               = true
  #   viewer_protocol_policy = "redirect-to-https"
  # }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none" #whitelist or blacklist can be options
      locations        = [] # use an empty array if type is none, otherwise list like this: ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Name = "${var.environment}"
    Environment = var.environment
  }

  viewer_certificate {
    # acm_certificate_arn = var.acm_arn
    # ssl_support_method = "sni-only"
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }
}


resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.bucket_name}oac-${var.environment}"
  description                       = "OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}