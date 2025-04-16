provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "flask_server" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "backend-server-key"         # Replace with your EC2 key pair name

  user_data = file("${path.module}/deploy_backend.sh")

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "CareerPilot-Backend"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH"
#   vpc_id      = "vpc-xxxxxxxx"  # Optional if using default VPC

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠️ Open to all for now
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_s3_bucket" "frontend_bucket" {
#   bucket = "careerpilot-frontend-your-unique-id"
#   acl    = "public-read"

#   website {
#     index_document = "index.html"
#     error_document = "index.html"
#   }

#   tags = {
#     Name = "CareerPilot Frontend"
#   }
# }
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "careerpilot-frontend-your-unique-id"

  tags = {
    Name = "CareerPilot Frontend"
  }
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.frontend_bucket.arn}/*"
      }
    ]
  })
}


# resource "aws_s3_bucket_acl" "frontend_bucket_acl" {
#   bucket = aws_s3_bucket.frontend_bucket.id
#   acl    = "public-read"
# }

resource "aws_s3_bucket_website_configuration" "frontend_website" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

