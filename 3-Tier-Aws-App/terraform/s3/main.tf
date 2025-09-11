resource "aws_s3_bucket" "frontend" {
  bucket = var.hosting_bucket

  tags = {
    Name = "Capstone-Frontend"
  }
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Make objects public
resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.frontend.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.frontend]
}
# Upload all frontend files to S3 automatically
resource "aws_s3_object" "frontend_files" {
  for_each = fileset("${path.module}/../frontend/dist", "**")

  bucket = aws_s3_bucket.frontend.bucket
  key    = each.value
  source = "${path.module}/../frontend/dist/${each.value}"
  etag   = filemd5("${path.module}/../frontend/dist/${each.value}")
  content_type = lookup(
    {
      html = "text/html",
      js   = "application/javascript",
      css  = "text/css",
      json = "application/json",
      png  = "image/png",
      jpg  = "image/jpeg",
      svg  = "image/svg+xml",
      ico  = "image/x-icon",
    },
    split(".", each.value)[length(split(".", each.value)) - 1],
    "binary/octet-stream"
  )
}


