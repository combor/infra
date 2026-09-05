data "desec_rrset" "nameservers" {
  domain  = desec_domain.kombor_ski.name
  subname = "@"
  type    = "NS"
}
