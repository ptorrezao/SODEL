variable "digital_ocean_token" {}
variable "ssh_key_file" {}
variable "domain_name" {}
variable "name" {}
variable "mysql_root_pwd" {}
variable "mysql_pwd" {}
variable "mysql_user" {}
variable "mysql_db" {}

module "vm" {
  source              = "modules/digitalocean_droplep_operations"
  digital_ocean_token = "${var.digital_ocean_token}"
  ssh_key_file        = "${var.ssh_key_file}"
  domain_name         = "${var.domain_name}"
  name                = "${var.name}"
  mysql_root_pwd      = "${var.mysql_root_pwd}"
  mysql_pwd           = "${var.mysql_pwd}"
  mysql_user          = "${var.mysql_user}"
  mysql_db            = "${var.mysql_db}"
}
