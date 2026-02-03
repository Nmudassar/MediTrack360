output "bucket_name" {
  value = aws_s3_bucket.dev-med-project.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.dev-med-project.arn
}
