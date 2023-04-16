resource "digitalocean_tag" "devops" {
  name = "devops"
}

resource "digitalocean_tag" "email" {
  name = var.user_email
}

resource "digitalocean_tag" "task_name" {
  name = var.task_name
}

resource "digitalocean_ssh_key" "user_ssh_key" {
  name       = "user_ssh_key"
  public_key = file(var.user_ssh_key_path)
}


resource "digitalocean_droplet" "lab" {
  image  = var.droplet_settings.image
  name   = var.droplet_settings.name
  size   = var.droplet_settings.size
  tags   = [digitalocean_tag.devops.id, digitalocean_tag.email.id, digitalocean_tag.task_name.id]
  ssh_keys = [digitalocean_ssh_key.user_ssh_key.fingerprint, data.digitalocean_ssh_key.rebrain.fingerprint]
}

locals {
  vps_ip = digitalocean_droplet.lab.ipv4_address
}

resource "aws_route53_record" "user_domain" {
  zone_id = data.aws_route53_zone.rebrain.zone_id
  name = "${var.rebrain_user_login}.${data.aws_route53_zone.rebrain.name}"
  type = "A"
  ttl = "300"
  records = [local.vps_ip]
}
