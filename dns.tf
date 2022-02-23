resource "aws_route53_zone" "kombor-ski" {
  name = "kombor.ski"
}

resource "aws_route53_record" "unifi" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "unifi.kombor.ski"
  type    = "A"
  ttl     = "3600"
  records = ["172.31.255.2"]
}

resource "aws_route53_record" "portal" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "portal.kombor.ski"
  type    = "A"
  ttl     = "3600"
  records = ["172.31.255.2"]
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "CAA"
  ttl     = "3600"
  records = ["0 issue \"letsencrypt.org\""]
}
