# variable "acm_arn" {
#   type = string
# }

variable "bucket_regional_domain_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "cf_aliases" {
  default = ["example.com", "www.example.com"]
  type = list(string)
  description = "Domain and subdomains"
}

variable "cloudfront_default_certificate" {
  default = true
  type = bool
}

variable "environment" {
  type = string
}

variable "default_cache_am" {
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}
variable "default_cached_methods" {
  default = ["GET", "HEAD"]
}

variable "default_forwarded_values_querystring" {
  default = true
}

variable "default_cache_cookies_forward" {
  default = "none"
}

variable "default_cache_query_string" {
  default = false
  type = bool
}

variable "default_min_ttl" {
  default = 0
  type = number
}

variable "default_default_ttl" {
  default = 3600
  type = number
}

variable "default_max_ttl" {
  default = 86400
  type = number
}
variable "default_object" {
  default = "index.html"
  type = string
}


variable "default_viewer_protocol_policy" {
  default = "allow-all"
  type = string
}

variable "price_class" {
  default = "PriceClass_200"
  type = string
}

