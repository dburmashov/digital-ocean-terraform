variable "digital_ocean_token" {
  description = "token for using api"
}

variable "aws_access_key" {
  description = "access_key"
}

variable "aws_secret_key" {
  description = "aws_secret_key"
}


variable "user_ssh_keys_path" {
  description = "user_ssh_keys_path with keys 'public', 'private'"
  type = map(string)
}

variable "user_email" {
  description = "user email in the format ii_at_rebrainme_com for ii@rebrainme.com"
}

variable "task_name" {
  description = "task_name"
}


variable "droplet_settings" {
  type = map(string)
  default = {
    image = "ubuntu-18-04-x64"
    name = "vm1"
    size = "s-1vcpu-1gb"
  }
}

variable "devs" {
  type    = list(string)
  default = ["username-lb", "username-app1", "username-app2"]
  description = "list of devs in format USERNAME-PURPOSE"
}

variable "password_length" {
  description = "password lenght for user in new droplets"
  default = 20
}

variable "password_special_symbols" {
  default = "!#$%&*()-_=+[]{}<>:?"
}


variable "output_file_path" {
  default = "./created-vms"
}
