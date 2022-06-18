data "aws_route53_zone" "main" {
  count        = var.root_dns_domain_name != null ? 1 : 0
  name         = "${var.stage}.${var.root_dns_domain_name}."
  private_zone = false
}
