resource "aws_security_group" "main" {
  name        = "homelab-security-group"
  description = "Security group for the homelab EC2 instance"
  vpc_id      = aws_vpc.main.id
}

# Rule for HTTP inbound traffic (Port 80)
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.internet
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Rule for HTTPS inbound traffic (Port 443)
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.internet
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# Rule for SSH inbound traffic (Port 22)
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.internet
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Rule for the Flask web application (Port 5000)
resource "aws_vpc_security_group_ingress_rule" "flask_app" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.internet
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}

# Rule for all outbound traffic
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.internet
  ip_protocol       = "-1"
}