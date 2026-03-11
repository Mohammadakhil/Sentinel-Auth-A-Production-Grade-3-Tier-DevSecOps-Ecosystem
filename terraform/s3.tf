# 1. The Main S3 Bucket Resource
resource "aws_s3_bucket" "sentinel_assets" {
  bucket = "secure_auth" # Must be unique!

  tags = {
    Name        = "Sentinel Assets"
    Environment = "Dev"
    Project     = "Sentinel-DevSecOps"
  }
}

resource "aws_s3_bucket_versioning" "assets_versioning" {
  bucket = aws_s3_bucket.sentinel_assets.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "assets_encryption" {
  bucket = aws_s3_bucket.sentinel_assets.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4. Block All Public Access (Security First!)
resource "aws_s3_bucket_public_access_block" "assets_access_block" {
  bucket = aws_s3_bucket.sentinel_assets.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
