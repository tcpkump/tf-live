provider "dns" {
  update {
    server = "10.100.1.53" # ns1.imkumpy.in
    # key_name, key_algorithm, and key_secret sourced from DNS_UPDATE_* env variables
  }
}
