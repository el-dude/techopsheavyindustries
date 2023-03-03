# Route 53 for domain

##### Imported ###################################
resource "aws_route53_zone" "main" {
    comment           = "Techops Heavy Industries Co. "
    name              = "techopsheavyindustries.com"
}
##### Imported ###################################

resource "aws_route53_record" "root-a" {
  zone_id             = aws_route53_zone.main.zone_id
  name                = var.domain_name
  type                = "A"
  #records            = [ aws_s3_bucket.root_bucket.bucket_domain_name ]
  #ttl                = 60

  alias {
    name              = aws_cloudfront_distribution.root_s3_distribution.domain_name
    zone_id           = aws_cloudfront_distribution.root_s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

### ACM shit
resource "aws_route53_record" "techopsheavyindustries_cert_dns" {
  allow_overwrite     = true
  name                = tolist(aws_acm_certificate.techopsheavyindustries_certificate.domain_validation_options)[0].resource_record_name
  records             = [tolist(aws_acm_certificate.techopsheavyindustries_certificate.domain_validation_options)[0].resource_record_value]
  type                = tolist(aws_acm_certificate.techopsheavyindustries_certificate.domain_validation_options)[0].resource_record_type
  zone_id             = aws_route53_zone.main.zone_id
  ttl                 = 60
}

