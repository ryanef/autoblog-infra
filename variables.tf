variable "aws_creds_profile" {
  # default = "default"
  description = "Name of profile found in ~/.aws/credentials or used by AWS CLI. Terraform will attempt to use that profile for access credentials if not supplied another way. Used in providers.tf"
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "bucket_name" {
  type = string
  default = "autoblog-project"
  description = "S3 Bucket names must have 3-63 characters, be unique, lowercase only. No underscores."
}

variable "enable_openid" {
  type = bool
  default = true
  description = "false if you don't want to create aws_iam_openid_connect_provider for GitHub Actions IAM Role management"
}

variable "environment" {
  type = string
  default = "dev"
  description = "dev, prod, etc. Mostly used for tagging and naming resources."
}

variable "github_account_name" {
  type = string
  description = "This is used in iam.tf where GitHub Actions is granted permission for uploading site files"
}

variable "github_repo_name" {
  type = string
  description = "This is the name of the Github Repo you've pushed your Astro blog files"
}

variable "github_branch" {
  type = string
  default = "main"
  description = "The branch name your GitHub Actions uses"
}
