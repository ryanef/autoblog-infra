data "aws_caller_identity" "current" {}
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
      condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
          "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.github_account_name}/${var.github_repo_name}:ref:refs/heads/${var.github_branch}"
      ]
    }
  }
  
}

data "aws_iam_policy_document" "github" {
  statement {

    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
    ]

    effect = "Allow"

    resources = [
      "${aws_ssm_parameter.s3.arn}",
      "${aws_ssm_parameter.cf.arn}",
      "${aws_ssm_parameter.role.arn}",
      "${aws_ssm_parameter.region.arn}",
    ]
  }

  statement {

    actions = [
      "cloudfront:CreateInvalidation",

    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }


  statement {
    actions = [
      "s3:*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${module.s3.bucket_name}",
      "arn:aws:s3:::${module.s3.bucket_name}/*",
    ]
  }
}
