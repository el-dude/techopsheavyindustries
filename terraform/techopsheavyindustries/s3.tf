# S3 bucket for website.
###
resource "aws_s3_bucket_website_configuration" "root_bucket" {
  bucket            = aws_s3_bucket.root_bucket.id
  index_document {
    suffix          = "index.html"
  }
  error_document {
    key             = "error.html"
  }
}

### Add CORS rules incase needed for css etc...
resource "aws_s3_bucket_cors_configuration" "root_bucket" {
  bucket            = aws_s3_bucket.root_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://${var.domain_name}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

###
resource "aws_s3_bucket" "root_bucket" {
  bucket            = var.bucket_name
  tags              = var.common_tags
}

resource "aws_s3_bucket_policy" "bucket_allow_access" {
  bucket            = aws_s3_bucket.root_bucket.id
  policy            = data.aws_iam_policy_document.allow_public_s3_read.json
}

# S3 Allow Public read access as data object
data "aws_iam_policy_document" "allow_public_s3_read" {
  statement {
    sid             = "PublicReadGetObject"
    effect          = "Allow"

    actions = [
      "s3:GetObject",
    ]

    principals {
      type          = "AWS"
      identifiers   = ["*"]
    }

    resources = [
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
}
