resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "this" {
  name   = coalesce(var.policy_name, "${var.role_name}-policy")
  policy = var.policy_document
}

resource "aws_iam_policy_attachment" "this" {
  name       = coalesce(var.attachment_name, "${var.role_name}-attachment")
  roles      = [aws_iam_role.this.name]
  policy_arn = aws_iam_policy.this.arn
}
