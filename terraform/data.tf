# Common data resources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_route53_zone" "main" {
  name         = "${var.stage}.${var.root_dns_domain_name}."
  private_zone = false
}

# Find a certificate issued by (not imported into) ACM
data "aws_acm_certificate" "wildcard" {
  domain      = "*.${var.stage}.${var.root_dns_domain_name}"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
