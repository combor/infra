resource "aws_route53_zone" "kombor-ski" {
  name = "kombor.ski"
}

resource "aws_route53_record" "unifi" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "unifi.kombor.ski"
  type    = "A"
  ttl     = "3600"
  records = [aws_eip.worker.public_ip]
}
