resource "digitalocean_droplet" "web" {
  image    = "docker-18-04"
  name     = "docker-main"
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
  tags     = ["${digitalocean_tag.terraform_tag.id}", "${digitalocean_tag.docker_tag.id}"]
  backups  = true

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
      "sudo docker swarm init --advertise-addr ${digitalocean_droplet.web.ipv4_address}",
      "sudo docker node update ${digitalocean_droplet.web.name} --label-add havebackups=true",
      "sudo docker node update ${digitalocean_droplet.web.name} --label-add bdstorage=true",
      "sudo docker node update ${digitalocean_droplet.web.name} --label-add volumestorage=true",
      "sudo chmod +x /tmp/scripts/setup-manager.sh",
      "echo ''TARGET_DOMAIN=${var.domain_name}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_ROOT_PASSWORD=${var.mysql_root_pwd}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_PASSWORD=${var.mysql_pwd}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_DATABASE=${var.mysql_user}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''MYSQL_USER=${var.mysql_db}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''registry_user=${var.registry_user}'' >> /tmp/scripts/docker-compose/.env",
      "echo ''registry_user_pwd=${var.registry_user_pwd}'' >> /tmp/scripts/docker-compose/.env",
      "sudo /tmp/scripts/setup-manager.sh",
    ]
  }
}