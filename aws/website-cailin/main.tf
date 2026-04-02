locals {
  primary_site_domain        = "cailinleber.com"
  primary_site_domain_dashed = replace(local.primary_site_domain, ".", "-")
  additional_site_domains    = []
  domains                    = concat([local.primary_site_domain], local.additional_site_domains)
  www_domains                = [for domain in local.domains : "www.${domain}"]

  redirect_target = "https://www.behance.net/gallery/241816001/Leber-Portfolio"
}

resource "aws_cloudfront_function" "redirect" {
  name    = "${local.primary_site_domain_dashed}-redirect"
  runtime = "cloudfront-js-2.0"
  publish = true
  code    = <<-EOF
    function handler(event) {
      return {
        statusCode: 301,
        statusDescription: "Moved Permanently",
        headers: {
          location: { value: "${local.redirect_target}" },
          "cache-control": { value: "max-age=86400" }
        }
      };
    }
  EOF
}

resource "aws_acm_certificate" "website_certificate" {
  domain_name               = local.primary_site_domain
  validation_method         = "DNS"
  subject_alternative_names = concat(local.additional_site_domains, local.www_domains)
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.website_certificate.domain_validation_options : dvo.domain_name => dvo
  }

  zone_id         = data.aws_route53_zone.site_zones[trimprefix(each.key, "www.")].zone_id
  name            = each.value.resource_record_name
  type            = each.value.resource_record_type
  records         = [each.value.resource_record_value]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "website_certificate" {
  certificate_arn         = aws_acm_certificate.website_certificate.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}

#trivy:ignore:AVD-AWS-0010
#trivy:ignore:AVD-AWS-0011
resource "aws_cloudfront_distribution" "main" {
  enabled         = true
  aliases         = concat(local.domains, local.www_domains)
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    default_ttl            = 86400
    max_ttl                = 86400
    target_origin_id       = "dummy"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.redirect.arn
    }
  }

  origin {
    domain_name = "example.com"
    origin_id   = "dummy"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.website_certificate.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

data "aws_route53_zone" "site_zones" {
  for_each = toset(local.domains)
  name     = each.value
}

resource "aws_route53_record" "site_records" {
  for_each = toset(local.domains)
  zone_id  = data.aws_route53_zone.site_zones[each.key].zone_id
  name     = each.key
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "site_www_records" {
  for_each = toset(local.domains)
  zone_id  = data.aws_route53_zone.site_zones[each.key].zone_id
  name     = "www.${each.key}"
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
