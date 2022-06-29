resource "aws_s3_bucket" "bucket" {
  acl = "private"
}

tags = {
  Name = test_bucket1
}

versioning {
  enabled = var.versioning
}

lifecycl_rule {
  enabled = var.lifecycle
}