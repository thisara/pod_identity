resource "aws_iam_user" "app_user" {
  name = "s3-file-user"

  tags = {
    Application = "file-api"
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_policy" "s3_app_policy" {
  name        = "s3-app-files-policy"
  description = "Allow application to list, read and write objects"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ListBucket"
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.app_files.arn
      },

      {
        Sid    = "ObjectAccess"
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = "${aws_s3_bucket.app_files.arn}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "app_user_s3" {
  user       = aws_iam_user.app_user.name
  policy_arn = aws_iam_policy.s3_app_policy.arn
}
