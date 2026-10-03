output "bucket_name" {
  value = aws_s3_bucket.app_files.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.app_files.arn
}

output "iam_user_name" {
  value = aws_iam_user.app_user.name
}

output "iam_user_arn" {
  value = aws_iam_user.app_user.arn
}
