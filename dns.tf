locals {
  internal_cnames = toset(["unifi", "sonarr", "radarr", "prowlarr", "deluge", "adguard"])
  external_cnames = toset(["plex", "overseerr", "photos"])
  proton_dkim     = toset(["protonmail", "protonmail2", "protonmail3"])
}

resource "aws_route53_zone" "kombor-ski" {
  name = "kombor.ski"
}

resource "aws_route53_record" "server" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "server.kombor.ski"
  type    = "A"
  ttl     = 3600
  records = ["172.31.255.3"]
}

resource "aws_route53_record" "lidarr" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "lidarr.kombor.ski"
  type    = "A"
  ttl     = 3600
  records = ["172.31.255.3"]
}

resource "aws_route53_record" "internal" {
  for_each = local.internal_cnames
  zone_id  = aws_route53_zone.kombor-ski.zone_id
  name     = "${each.key}.kombor.ski"
  type     = "CNAME"
  ttl      = 3600
  records  = ["server.kombor.ski"]
}

resource "aws_route53_record" "external" {
  for_each = local.external_cnames
  zone_id  = aws_route53_zone.kombor-ski.zone_id
  name     = "${each.key}.kombor.ski"
  type     = "CNAME"
  ttl      = 3600
  records  = ["ciepla-zupa.chickenkiller.com"]
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"letsencrypt.org\""]
}

resource "aws_route53_record" "proton_verification" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "TXT"
  ttl     = 3600
  records = ["protonmail-verification=3ab66f95a1d68e13eb6e4cb285c8075bccd998db", "v=spf1 include:_spf.protonmail.ch mx ~all", "v=DMARC1; p=quarantine"]
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "_dmarc.kombor.ski"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=quarantine"]
}

resource "aws_route53_record" "proton_dkim" {
  for_each = local.proton_dkim
  zone_id  = aws_route53_zone.kombor-ski.zone_id
  name     = "${each.key}._domainkey.kombor.ski"
  type     = "CNAME"
  ttl      = 3600
  records  = ["${each.key}.domainkey.dbjmzzyfyzyrvfq7cfoza4htlq44zbjkph6eu6zqezt7xx3bgaoxa.domains.proton.ch"]
}

resource "aws_route53_record" "proton_mx" {
  zone_id = aws_route53_zone.kombor-ski.zone_id
  name    = "kombor.ski"
  type    = "MX"
  ttl     = 3600
  records = ["10 mail.protonmail.ch", "20 mailsec.protonmail.ch"]
}
