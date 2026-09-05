# Scoped credential for Traefik's Let's Encrypt DNS-01 challenges, replacing the Route53
# IAM robot user in users.tf. The default policy denies writes; the only grant is TXT
# records within kombor.ski.
#
# `subname` is deliberately left unset (wildcard). Traefik's certificate strategy lives
# outside this repo: a wildcard *.kombor.ski cert challenges at _acme-challenge.kombor.ski,
# but per-host certs challenge at _acme-challenge.<host>. If Traefik only ever issues a
# wildcard cert, this can be tightened with `subname = "_acme-challenge"`.

resource "desec_token" "traefik" {
  name               = "traefik-acme"
  perm_create_domain = false
  perm_delete_domain = false
  perm_manage_tokens = false
  max_unused_period  = "90 00:00:00"
}

# Deny by default. deSEC requires this catch-all policy to exist before any specific one.
resource "desec_token_policy" "traefik_default" {
  token_id   = desec_token.traefik.id
  perm_write = false
}

resource "desec_token_policy" "traefik_txt" {
  token_id   = desec_token.traefik.id
  domain     = desec_domain.kombor_ski.name
  type       = "TXT"
  perm_write = true

  depends_on = [desec_token_policy.traefik_default]
}
