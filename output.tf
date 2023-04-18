output "new_passwords" {
  value = [for i in range(var.droplet_count) : "${digitalocean_droplet.lab[i].name}: ${nonsensitive(random_password.password[i].result)}"]
}
