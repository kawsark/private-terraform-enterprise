output "pes_fqdn" {
  value = "${aws_route53_record.pes.fqdn}"
}

output "public_ip" {
  value = "${aws_eip.pes.*.public_ip}"
}
