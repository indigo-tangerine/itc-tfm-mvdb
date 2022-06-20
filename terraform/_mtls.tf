#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "mtls" {
  bucket = "${var.stage}-${var.service}-truststore-${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_acl" "mtls" {
  bucket = aws_s3_bucket.mtls.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "mtls" {
  bucket = aws_s3_bucket.mtls.id
  versioning_configuration {
    status = "Enabled"
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "mtls" {
  bucket = aws_s3_bucket.mtls.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "mtls" {
  bucket                  = aws_s3_bucket.mtls.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_object" "truststore" {
  bucket = aws_s3_bucket.mtls.id
  key    = "truststore.pem"
  source = local.truststore_cert_path
  etag   = filemd5(local.truststore_cert_path)
}

locals {
  truststore_cert_path = "../certs/truststore.pem"
  truststore_uri       = "s3://${aws_s3_bucket.mtls.id}/${aws_s3_object.truststore.id}"
}
