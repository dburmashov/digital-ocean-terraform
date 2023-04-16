resource "digitalocean_tag" "devops" {
  name = "devops"
}

resource "digitalocean_tag" "user_email" {
  name = "user_email"
}


resource "digitalocean_ssh_key" "user_ssh_key" {
  name       = "user_ssh_key"
  public_key = file(var.user_ssh_key_path)
}


resource "digitalocean_droplet" "lab" {
  image  = var.droplet_settings.image
  name   = var.droplet_settings.name
  size   = var.droplet_settings.size
  tags   = [digitalocean_tag.devops.id, digitalocean_tag.user_email.id]
  ssh_keys = [digitalocean_ssh_key.user_ssh_key.fingerprint]
}
