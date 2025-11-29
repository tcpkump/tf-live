locals {
  a_records = {
    "ender3"           = "192.168.10.100" # TODO: update now that I'm using different subnet for wifi
    "serverrack-power" = "192.168.10.10"  # TODO: same

    "ext-rp" = "192.168.0.87"
    "rp"     = "192.168.0.88"

    "gitea"          = "192.168.0.91"
    "gitea-actions"  = "192.168.0.92"
    "mx1"            = "192.168.0.89"
    "postgres"       = "192.168.0.90"
    "prod-mc"        = "192.168.0.239"
    "proxmox-1"      = "192.168.0.100"
    "proxmox-backup" = "192.168.0.105"
    "rpi"            = "192.168.0.65"
    "unraid"         = "192.168.0.104"
    "zabbix"         = "192.168.0.93"
  }

  cname_records = {
    "git"         = "rp.imkumpy.in."
    "omada"       = "rp.imkumpy.in."
    "plex"        = "rp.imkumpy.in."
    "proxmox"     = "rp.imkumpy.in."
    "qbittorrent" = "rp.imkumpy.in."
  }
}

resource "dns_a_record_set" "records" {
  for_each = local.a_records

  zone      = "imkumpy.in."
  name      = each.key
  addresses = [each.value]
  ttl       = 3600
}

resource "dns_cname_record" "records" {
  for_each = local.cname_records

  zone  = "imkumpy.in."
  name  = each.key
  cname = each.value
  ttl   = 3600
}
