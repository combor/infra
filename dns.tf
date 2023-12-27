resource "aws_route53_zone" "kombor-ski" {
  name = "kombor.ski"
}

resource "aws_route53_record" "unifi" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "unifi.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["ciepla-zupa.chickenkiller.com"]
}

resource "aws_route53_record" "pihole" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "pihole.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["ciepla-zupa.chickenkiller.com"]
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "CAA"
  ttl     = "3600"
  records = ["0 issue \"letsencrypt.org\""]
}

resource "aws_route53_record" "proton_verification" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "TXT"
  ttl     = "3600"
  records = ["protonmail-verification=3ab66f95a1d68e13eb6e4cb285c8075bccd998db", "v=spf1 include:_spf.protonmail.ch mx ~all", "v=DMARC1; p=quarantine"]
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "_dmarc.kombor.ski"
  type    = "TXT"
  ttl     = "3600"
  records = ["v=DMARC1; p=quarantine"]
}

resource "aws_route53_record" "proton_dkim" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "protonmail._domainkey.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["protonmail.domainkey.dbjmzzyfyzyrvfq7cfoza4htlq44zbjkph6eu6zqezt7xx3bgaoxa.domains.proton.ch"]
}

resource "aws_route53_record" "proton_dkim2" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "protonmail2._domainkey.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["protonmail2.domainkey.dbjmzzyfyzyrvfq7cfoza4htlq44zbjkph6eu6zqezt7xx3bgaoxa.domains.proton.ch"]
}

resource "aws_route53_record" "proton_dkim3" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "protonmail3._domainkey.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["protonmail3.domainkey.dbjmzzyfyzyrvfq7cfoza4htlq44zbjkph6eu6zqezt7xx3bgaoxa.domains.proton.ch"]
}

resource "aws_route53_record" "proton_mx" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "MX"
  ttl     = "3600"
  records = ["10 mail.protonmail.ch", "20 mailsec.protonmail.ch"]
}

resource "aws_route53_record" "external" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "plex.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["ciepla-zupa.chickenkiller.com"]
}

resource "aws_route53_record" "overseerr" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "overseerr.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["ciepla-zupa.chickenkiller.com"]
}

resource "aws_route53_record" "portal" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "portal.kombor.ski"
  type    = "CNAME"
  ttl     = "3600"
  records = ["ciepla-zupa.chickenkiller.com"]
}
