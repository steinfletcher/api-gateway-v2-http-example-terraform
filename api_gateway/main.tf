data "aws_acm_certificate" "domain" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}

data "aws_route53_zone" zone {
  name = "${join(".", slice(split(".", var.domain_name), 1, 3))}."
}

resource "aws_cloudformation_stack" "api" {
  name          = var.name
  template_body = file("${path.module}/api.yml")
  parameters = {
    Name              = var.name
    DomainName        = var.domain_name
    HostedZoneName    = data.aws_route53_zone.zone.name
    CertificateDomain = data.aws_acm_certificate.domain.domain
    CertificateArn    = data.aws_acm_certificate.domain.arn
    ApiMappingKey     = var.api_mapping_key
  }
}
