
resource "aws_security_group" "allow_rule" {
  name        = "allow_https"
  description = "Allow ssh and https rules"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = [22, 80, 8080, 3000]
    iterator = port
    content {
      description = "Allow port ${port.value}"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "https-ssh-sg"
  }
}
