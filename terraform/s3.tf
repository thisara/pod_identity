resource "aws_s3_bucket" "app_files" {
  bucket = var.bucket_name

  tags = {
    Name        = "Application Files"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "app_files" {
  bucket = aws_s3_bucket.app_files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "app_files" {
  bucket = aws_s3_bucket.app_files.id

  versioning_configuration {
    status = "Enabled"
  }
}
