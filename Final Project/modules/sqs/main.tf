resource "aws_sqs_queue" "incoming_queue" {
  name = var.incoming_queue_name
}

resource "aws_sqs_queue" "completion_queue" {
  name = var.completion_queue_name
}


