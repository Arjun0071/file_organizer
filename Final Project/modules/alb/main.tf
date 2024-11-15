
# Security group for the ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.name}-sg"
  description = "Security group for the ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic on port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

# Load Balancer
resource "aws_lb" "main" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnets
}

# Target groups
resource "aws_lb_target_group" "main" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "python_app" {
  name     = var.python_target_group_name
  port     = var.python_target_group_port
  protocol = var.python_target_group_protocol
  vpc_id   = var.vpc_id
}

# Listeners
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "python" {
  load_balancer_arn = aws_lb.main.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.python_app.arn
  }
}

# Outputs
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
