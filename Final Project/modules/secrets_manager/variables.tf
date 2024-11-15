variable "secret_name" {
  description = "The name of the Secrets Manager secret to be created"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket whose details are to be stored in the secret"
  type        = string
}

variable "incoming_queue_url" {
  description = "The URL of the incoming SQS queue to be stored in the secret"
  type        = string
}

variable "completion_queue_url" {
  description = "The URL of the completion SQS queue to be stored in the secret"
  type        = string
}
