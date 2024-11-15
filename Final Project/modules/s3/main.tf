resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.main.bucket
}
