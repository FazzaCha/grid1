provider "aws" {
  region ="us-east-1"
  access_key="AKIA5STC2SJ6VJPTDQIP"
  secret_key="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"

}

resource "aws_s3_bucket" "bucket" {
  acl = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    id = "log"

    expiration {
      days = 90
    }

    filter {
      and {
        prefix = "log/"

        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }
}
