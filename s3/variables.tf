variable "bucket_name"{
  type = string
}

variable "cloudfront_id" {
  type = string
}

variable "environment"{
  type = string
}

variable "s3_force_destroy" {
  default = false
  type = string
}