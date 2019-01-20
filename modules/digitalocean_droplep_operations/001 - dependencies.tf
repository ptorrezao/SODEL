resource "digitalocean_ssh_key" "default" {
  name       = "DT-Office ssh key"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}

resource "digitalocean_domain" "default" {
  name       = "${var.domain_name}"
  ip_address = "${digitalocean_droplet.web.ipv4_address}"
}

resource "digitalocean_record" "wildkey" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "*"
  value  = "${digitalocean_droplet.web.ipv4_address}"
}

resource "digitalocean_tag" "terraform_tag" {
  name = "terraform"
}

resource "digitalocean_tag" "docker_tag" {
  name = "docker"
}
