data "digitalocean_ssh_key" "rebrain" {
  name = "REBRAIN.SSH.PUB.KEY"
}

data "aws_route53_zone" "rebrain" {
  name = "devops.rebrain.srwx.net"
}
