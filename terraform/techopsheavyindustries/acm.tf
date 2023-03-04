# SSL Certificate

resource "aws_acm_certificate" "techopsheavyindustries_certificate" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]
  tags                      = var.common_tags
  lifecycle {
    create_before_destroy   = true
  }
}

resource "aws_acm_certificate_validation" "techopsheavyindustries_cert_validate" {
  certificate_arn           = aws_acm_certificate.techopsheavyindustries_certificate.arn
  validation_record_fqdns   = [aws_route53_record.techopsheavyindustries_cert_dns.fqdn]
}

