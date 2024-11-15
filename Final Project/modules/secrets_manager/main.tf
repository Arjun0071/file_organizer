
resource "aws_secretsmanager_secret" "main" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id = aws_secretsmanager_secret.main.id
  secret_string = jsonencode({
    s3_bucket            = var.s3_bucket_name
    incoming_queue_url   = var.incoming_queue_url
    completion_queue_url = var.completion_queue_url
  })
}

output "secret_arn" {
  value = aws_secretsmanager_secret.main.arn
}
