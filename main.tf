locals {
  # Side step the leading and following slash issue by removing the provided
  # ones and adding them in the format the module requires
  bucket_prefix = trim(var.bucket_prefix, "/")
}

resource "aws_s3_bucket" "target" {
  count = var.create_bucket ? 1 : 0
  
  bucket = var.bucket_name
}

data "aws_s3_bucket" "target" {
  bucket = var.create_bucket ? aws_s3_bucket.target[0].id : var.bucket_name
}

resource "aws_s3_object" "test" {
  bucket = data.aws_s3_bucket.target.id #
  key    = "${local.bucket_prefix}/test.txt"
  source = "${path.module}/test.txt"
}