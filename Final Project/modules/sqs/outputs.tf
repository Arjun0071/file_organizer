output "incoming_queue_url" {
  value = aws_sqs_queue.incoming_queue.url
}

output "completion_queue_url" {
  value = aws_sqs_queue.completion_queue.url
}
