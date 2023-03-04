# Cloudfront distribution for main s3 site.
resource "aws_cloudfront_distribution" "root_s3_distribution" {
  origin {
    domain_name               = aws_s3_bucket.root_bucket.bucket_regional_domain_name
    origin_id                 = "S3-${var.bucket_name}"
    custom_origin_config {
      http_port               = 80
      https_port              = 443
      origin_protocol_policy  = "http-only"
      origin_ssl_protocols    = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled                     = true
  is_ipv6_enabled             = true

  aliases                     = [var.domain_name]
  default_root_object         = "index.html"

  default_cache_behavior {
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    target_origin_id          = "S3-${var.bucket_name}"

    forwarded_values {
      query_string            = true

      cookies {
        forward               = "none"
      }

      headers                 = ["Origin"]
    }

    viewer_protocol_policy    = "redirect-to-https"
    min_ttl                   = 0
    default_ttl               = 86400
    max_ttl                   = 31536000
  }

  custom_error_response {
    error_code                = 400
    response_code             = 400
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 403
    response_code             = 403
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 404
    response_code             = 404
    error_caching_min_ttl     = 300
    response_page_path        = "/404.html"
  }
  custom_error_response {
    error_code                = 405
    response_code             = 405
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 414
    response_code             = 414
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 416
    response_code             = 416
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 500
    response_code             = 500
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 501
    response_code             = 501
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 502
    response_code             = 502
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 503
    response_code             = 503
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }
  custom_error_response {
    error_code                = 504
    response_code             = 504
    error_caching_min_ttl     = 300
    response_page_path        = "/error.html"
  }

  restrictions {
    geo_restriction {
      restriction_type        = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn       = aws_acm_certificate_validation.techopsheavyindustries_cert_validate.certificate_arn
    ssl_support_method        = "sni-only"
    minimum_protocol_version  = "TLSv1.1_2016"
  }

  tags                        = var.common_tags
}
