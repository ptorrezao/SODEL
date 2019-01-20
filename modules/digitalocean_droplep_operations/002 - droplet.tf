resource "digitalocean_droplet" "web" {
  image    = "docker-18-04"
  name     = "docker-main"
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
  tags     = ["${digitalocean_tag.terraform_tag.id}", "${digitalocean_tag.docker_tag.id}"]

  provisioner "file" {
    source      = "modules/digitalocean_droplep_operations/scripts"
    destination = "/tmp/scripts"

    connection {
      user        = "root"
      type        = "ssh"
      private_key = "${file("${var.ssh_key_file}")}"
      timeout     = "2m"
    }
  }

  provisioner "remote-exec" {
    connection {
      user        = "root"
      type        = "ssh"
      private_key = "${file("${var.ssh_key_file}")}"
      timeout     = "2m"
    }

    inline = [
      "sudo chmod +x /tmp/scripts/setup.sh",
      "echo ''TARGET_DOMAIN=${var.domain_name}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_ROOT_PASSWORD=${var.mysql_root_pwd}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_PASSWORD=${var.mysql_pwd}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_DATABASE=${var.mysql_user}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_USER=${var.mysql_db}'' >> /tmp/scripts/docker-compose/.env",
      "sudo /tmp/scripts/setup.sh",
      "ls  /tmp -la",
    ]
  }
}
