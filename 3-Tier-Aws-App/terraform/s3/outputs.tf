output "s3_website_url" {
  description = "S3 static website hosting endpoint"
  value       = aws_s3_bucket_website_configuration.frontend.website_endpoint
}

