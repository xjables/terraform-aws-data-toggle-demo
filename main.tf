locals {
  # Side step the leading and following slash issue by removing the provided
  # ones and adding them in the format the module requires
  bucket_prefix  = trim(var.bucket_prefix, "/")
  test_file_path = "${path.module}/test.txt"
}

resource "aws_s3_bucket" "target" {
  count = var.create_bucket ? 1 : 0

  bucket        = var.bucket_name
  force_destroy = true
}

data "aws_s3_bucket" "target" {
  bucket = var.create_bucket ? aws_s3_bucket.target[0].id : var.bucket_name
}

resource "aws_s3_object" "test" {
  bucket = data.aws_s3_bucket.target.id #
  key    = "${local.bucket_prefix}/test.txt"
  source = local.test_file_path
  etag   = filemd5(local.test_file_path)

  force_destroy = true
}