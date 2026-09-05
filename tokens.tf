resource "desec_token" "traefik" {
  name               = "traefik-acme"
  perm_create_domain = false
  perm_delete_domain = false
  perm_manage_tokens = false
  max_unused_period  = "90 00:00:00"
}

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
