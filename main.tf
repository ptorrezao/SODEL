variable "digital_ocean_token" {}
variable "ssh_key_file" {}
variable "domain_name" {}
variable "name" {}

module "vm" {
  source   = "modules/digitalocean_droplep_operations"
  digital_ocean_token ="${var.digital_ocean_token}"
  ssh_key_file = "${var.ssh_key_file}"
  domain_name = "${var.domain_name}"
  name = "${var.name}"
}
