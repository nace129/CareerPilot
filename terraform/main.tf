provider "aws" {
  region = "us-east-1"
#   profile = "AdministratorAccess-588738575824"
}

resource "aws_instance" "flask_server" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2
  instance_type = "t2.micro"
  key_name      = "backend-server-key"         # Replace with your EC2 key pair name

  user_data = file("deploy_backend.sh")

  tags = {
    Name = "CareerPilot-Backend"
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

