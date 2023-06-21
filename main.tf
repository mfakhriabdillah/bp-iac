provider "google" {
  credentials = file("studidevops-bigpro-fakhri-8c0153e110c9.json")
  project     = "studidevops-bigpro-fakhri"
  region      = "us-central1"
}

module "bigpro_vpc" {
  source       = "./modules/network/vpc"
  network_name = "bigpro-vpc"
}

module "bigpro_subnet" {
  source      = "./modules/network/subnet"
  subnet_name = "bigpro-subnet"
  subnet_cidr = "10.0.0.0/24"
  network_id  = module.bigpro_vpc.vpc_id
}

module "ssh_firewall_rules" {
  source           = "./modules/network/firewall_rules"
  project_id       = "studidevops-bigpro-fakhri"
  network_id       = module.bigpro_vpc.vpc_id
  firewall_rule_id = "allow-ssh"
  ports_allow      = ["22"]
  target_tags_id   = ["allow-ssh"]
}

module "devops_bastion" {
  source        = "./modules/compute_instance"
  instance_name = "bastion-instance"
  machine_type  = "n1-standard-1"
  zone          = "us-central1-a"
  tags          = ["allow-ssh"]
  image         = "ubuntu-os-cloud/ubuntu-2004-lts"
  network       = module.bigpro_vpc.vpc_id
  subnet        = module.bigpro_subnet.subnet_id
  ssh_pubkey = "fakhri:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMKsCC8rJUvA8jwemWvMdk2RQ0VheM71DAXqi6tCqg8R8+DUp9p76GudmKOlIe/PnagAaJYTDSQDGujKfugiUObVDOlVrDL8wKrz3sTsXXeg7K8JUiDC4EAYrgf+MW2ETCf2mTKxF30pdU+7ZOLBKwH45spT1ZNyHOHpybG+k859zVzY87XKDsrPL8S1wfe6eET6TrXHuRPyPAkYqbLYseQtu2Ua132NioNcW68So356HTEsRHQrHnc7xHSFol+8NfGy/QRPiTy5zvYhqA8LzolX6K56I3nIA7dQ20GqxrKD+JtZPKEftRYQhPEqvlwPrD6vFV16ZImixNfT6108kbqxYjkbJFB9KK91D1PE2rQovJmYmAzQE8FEK4H7uIwfdr73wdlO0LmGmjopzUpEIxXrysUfhUItW48LjqZgxOxG/jVj4wIRKC7MhFrcLzxnMasZKcWgEWw/ohebRuhmP0tdh03rgb7Ihq09XuCER1Xtxukbg5TP91bjnLI4VDu/c= faseero0@mint"
}

