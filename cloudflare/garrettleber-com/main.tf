locals {
  domain = "garrettleber.com"

  root_a_records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]
}

resource "cloudflare_dns_record" "root_a" {
  for_each = toset(local.root_a_records)

  zone_id = var.cloudflare_zone_id
  name    = local.domain
  type    = "A"
  content = each.value
  ttl     = 1 # 1 = automatic (proxied records require this)
  proxied = false
}

resource "cloudflare_dns_record" "www_cname" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "CNAME"
  content = "tcpkump.github.io"
  ttl     = 1
  proxied = false
}
