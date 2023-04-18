resource "digitalocean_tag" "module" {
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
  public_key = file(var.user_ssh_keys_path.public)
}

resource "random_password" "password" {
  count            = length(var.devs)
  length           = var.password_length
  special          = true
  override_special = var.password_special_symbols
}


resource "digitalocean_droplet" "lab" {
  count = length(var.devs)
  image  = var.droplet_settings.image
  name   = "${var.droplet_settings.name}-${count.index}"
  size   = var.droplet_settings.size
  tags   = [digitalocean_tag.module.id, digitalocean_tag.email.id, digitalocean_tag.task_name.id]
  ssh_keys = [digitalocean_ssh_key.user_ssh_key.fingerprint, data.digitalocean_ssh_key.rebrain.fingerprint]

  connection {
    type     = "ssh"
    user     = "root"
    private_key = file(var.user_ssh_keys_path.private)
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'root:${random_password.password[count.index].result}' | sudo chpasswd"
    ]
  }
}

locals {
  vps_ips = digitalocean_droplet.lab[*].ipv4_address
}


resource "aws_route53_record" "user_domain" {
  count = length(var.devs)
  zone_id = data.aws_route53_zone.rebrain.zone_id
  name = "${var.devs[count.index]}"
  type = "A"
  ttl = "300"
  records = [element(local.vps_ips, count.index)]
}

locals {
  vms_info = [for i in range(length(var.devs)) : {
    number = i + 1
    fqdn = aws_route53_record.user_domain[i].fqdn
    ip = local.vps_ips[i]
    password = nonsensitive(random_password.password[i].result)
  }]
}

resource "local_file" "vms_data" {
  content  = templatefile("./list-vms.tftpl", {vms_info = local.vms_info}) 
  filename = "${path.module}/${var.output_file_path}"
}
