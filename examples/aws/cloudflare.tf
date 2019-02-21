# Optional: setup a Cloudflare domain
# Need the following environment variables set for Cloudflare DNS provisioning:
#   export CLOUDFLARE_EMAIL="cloudflare_api_key"
#   export CLOUDFLARE_TOKEN="cloudflare_email"
# See: https://www.terraform.io/docs/providers/cloudflare/index.html#argument-reference

variable "create_cloudflare_dns" {
  description = "Set value to 1 to create cloudflare DNS records."
  default = "0"
}

variable "cloudflare_domain" {
  description = "Set higher level domain name to correct value if create_cloudflare_dns 1. E.g. example.com"
  default = "example.com"
}

# Adds the server record to domain
resource "cloudflare_record" "cf_ptfe" {
  count  = "${var.create_cloudflare_dns == "0" ? 0 : 2}"
  domain = "${var.cloudflare_domain}"
  name   = "ptfe${count.index}"
  value  = "${module.pes.public_ip[count.index]}"
  type   = "A"
  ttl    = 1
}

output "cloudflare_dns" {
  value = "${cloudflare_record.cf_ptfe.*.hostname}"
}