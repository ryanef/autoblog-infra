resource "aws_iam_openid_connect_provider" "default" {
  count = var.enable_openid ? 1 : 0 
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["cf23df2207d99a74fbe169e3eba035e633b65d94"]
}

resource "aws_iam_policy" "githubrole" {
  name   = "ghActionsPolicy-${random_integer.r.result}"
  policy = data.aws_iam_policy_document.github.json
}

resource "aws_iam_role" "ghactions" {
  name               = "ghActionsRole-${random_integer.r.result}"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "ghaattachment-${random_integer.r.result}"

  roles      = [aws_iam_role.ghactions.id]

  policy_arn = aws_iam_policy.githubrole.arn
}