resource "desec_domain" "kombor_ski" {
  name = "kombor.ski"
}

resource "desec_rrset" "server" {
  domain  = desec_domain.kombor_ski.name
  subname = "server"
  type    = "A"
  ttl     = 3600
  rdata   = ["192.168.0.10"]
}

resource "desec_rrset" "lidarr" {
  domain  = desec_domain.kombor_ski.name
  subname = "lidarr"
  type    = "A"
  ttl     = 3600
  rdata   = ["172.31.255.3"]
}

resource "desec_rrset" "internal" {
  for_each = local.internal_cnames
  domain   = desec_domain.kombor_ski.name
  subname  = each.key
  type     = "CNAME"
  ttl      = 3600
  rdata    = ["server.kombor.ski."]
}

resource "desec_rrset" "external" {
  for_each = local.external_cnames
  domain   = desec_domain.kombor_ski.name
  subname  = each.key
  type     = "CNAME"
  ttl      = 3600
  rdata    = ["ciepla-zupa.chickenkiller.com."]
}

resource "desec_rrset" "caa" {
  domain  = desec_domain.kombor_ski.name
  subname = "@"
  type    = "CAA"
  ttl     = 3600
  rdata   = ["0 issue \"letsencrypt.org\""]
}

resource "desec_rrset" "proton_verification" {
  domain  = desec_domain.kombor_ski.name
  subname = "@"
  type    = "TXT"
  ttl     = 3600
  rdata = [
    "\"protonmail-verification=3ab66f95a1d68e13eb6e4cb285c8075bccd998db\"",
    "\"v=spf1 include:_spf.protonmail.ch mx ~all\"",
  ]
}

resource "desec_rrset" "dmarc" {
  domain  = desec_domain.kombor_ski.name
  subname = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  rdata   = ["\"v=DMARC1; p=quarantine\""]
}

resource "desec_rrset" "proton_dkim" {
  for_each = local.proton_dkim
  domain   = desec_domain.kombor_ski.name
  subname  = "${each.key}._domainkey"
  type     = "CNAME"
  ttl      = 3600
  rdata    = ["${each.key}.domainkey.dbjmzzyfyzyrvfq7cfoza4htlq44zbjkph6eu6zqezt7xx3bgaoxa.domains.proton.ch."]
}

resource "desec_rrset" "proton_mx" {
  domain  = desec_domain.kombor_ski.name
  subname = "@"
  type    = "MX"
  ttl     = 3600
  rdata   = ["10 mail.protonmail.ch.", "20 mailsec.protonmail.ch."]
}
