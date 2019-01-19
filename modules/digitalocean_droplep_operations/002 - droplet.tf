resource "digitalocean_droplet" "web" {
  image  = "docker-18-04"
  name   = "docker-main"
  region = "ams3"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
  tags   = ["${digitalocean_tag.terraform_tag.id}","${digitalocean_tag.docker_tag.id}" ]
}
