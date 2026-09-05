data "desec_rrset" "nameservers" {
  domain  = desec_domain.kombor_ski.name
  subname = "@"
  type    = "NS"
}

output "desec_nameservers" {
  description = "Nameservers to set at the registrar when cutting over from Route53."
  value       = data.desec_rrset.nameservers.rdata
}

# Publish these at the registrar ONLY after `dig @b0.nic.ski kombor.ski NS` shows the
# deSEC nameservers and the 3600s delegation TTL has elapsed. Publishing a DS while
# resolvers still reach Route53 (an unsigned zone) is a domain-wide SERVFAIL.
output "dnssec_ds_records" {
  description = "DS records for DNSSEC delegation, to publish at the registrar."
  value       = flatten([for k in desec_domain.kombor_ski.keys : k.ds if k.managed])
}

output "traefik_token" {
  description = "deSEC token for Traefik's DNS-01 challenge. Read with `terraform output -raw traefik_token`."
  value       = desec_token.traefik.token
  sensitive   = true
}
