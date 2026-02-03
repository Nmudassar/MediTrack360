resource "aws_s3_bucket" "dev-med-project" {
  bucket = var.bucket_name

  tags = {
    Project     = var.project
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.dev-med-project.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.dev-med-project.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.dev-med-project.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Optional: create "folders" (S3 prefixes) by uploading empty objects
resource "aws_s3_object" "bronze" {
  bucket  = aws_s3_bucket.dev-med-project.id
  key     = "bronze/"
  content = ""
}
resource "aws_s3_object" "silver" {
  bucket  = aws_s3_bucket.dev-med-project.id
  key     = "silver/"
  content = ""
}
resource "aws_s3_object" "gold" {
  bucket  = aws_s3_bucket.dev-med-project.id
  key     = "gold/"
  content = ""
}
