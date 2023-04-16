variable "digital_ocean_token" {
  description = "token for using api"
}

variable "aws_access_key" {
  description = "access_key"
}

variable "aws_secret_key" {
  description = "aws_secret_key"
}


variable "user_ssh_key_path" {
  description = "user_ssh_key_path"
}

variable "user_email" {
  description = "user email in the format ii_at_rebrainme_com for ii@rebrainme.com"
}

variable "rebrain_user_login" {
  description = "user login on platform rebrain"
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

variable "droplet_count" {
  description = "droplet_count"
  type = number
}
