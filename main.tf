provider "google" {
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

module "http_firewall_rules" {
  source           = "./modules/network/firewall_rules"
  project_id       = "studidevops-bigpro-fakhri"
  network_id       = module.bigpro_vpc.vpc_id
  firewall_rule_id = "allow-http"
  ports_allow      = ["80", "443"]
  target_tags_id   = ["allow-http"]
}

module "jenkins_firewall_rules" {
  source           = "./modules/network/firewall_rules"
  project_id       = "studidevops-bigpro-fakhri"
  network_id       = module.bigpro_vpc.vpc_id
  firewall_rule_id = "allow-jenkins"
  ports_allow      = ["8080"]
  target_tags_id   = ["allow-jenkins"]
}

module "grafana_firewall_rules" {
  source           = "./modules/network/firewall_rules"
  project_id       = "studidevops-bigpro-fakhri"
  network_id       = module.bigpro_vpc.vpc_id
  firewall_rule_id = "allow-grafana"
  ports_allow      = ["3000"]
  target_tags_id   = ["allow-grafana"]
}

module "devops_bastion" {
  source        = "./modules/compute_instance"
  instance_name = "bastion-instance"
  machine_type  = "n1-standard-1"
  zone          = "us-central1-a"
  tags          = ["allow-ssh","allow-http"]
  image         = "ubuntu-os-cloud/ubuntu-2004-lts"
  network       = module.bigpro_vpc.vpc_id
  subnet        = module.bigpro_subnet.subnet_id
  ssh_pubkey = "fakhri:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMKsCC8rJUvA8jwemWvMdk2RQ0VheM71DAXqi6tCqg8R8+DUp9p76GudmKOlIe/PnagAaJYTDSQDGujKfugiUObVDOlVrDL8wKrz3sTsXXeg7K8JUiDC4EAYrgf+MW2ETCf2mTKxF30pdU+7ZOLBKwH45spT1ZNyHOHpybG+k859zVzY87XKDsrPL8S1wfe6eET6TrXHuRPyPAkYqbLYseQtu2Ua132NioNcW68So356HTEsRHQrHnc7xHSFol+8NfGy/QRPiTy5zvYhqA8LzolX6K56I3nIA7dQ20GqxrKD+JtZPKEftRYQhPEqvlwPrD6vFV16ZImixNfT6108kbqxYjkbJFB9KK91D1PE2rQovJmYmAzQE8FEK4H7uIwfdr73wdlO0LmGmjopzUpEIxXrysUfhUItW48LjqZgxOxG/jVj4wIRKC7MhFrcLzxnMasZKcWgEWw/ohebRuhmP0tdh03rgb7Ihq09XuCER1Xtxukbg5TP91bjnLI4VDu/c= faseero0@mint"
  desired_status = "TERMINATED"
#   metadata_startup_script = <<-EOF
#     export TOKEN='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'
#     export USERNAME='mfakhriabdillah'
#     export SECRET='Atlantis123'
#     export IP_ADDRESS='${curl -s ifconfig.me}'
#     sudo atlantis server --atlantis-url="http://IP_ADDRESS" --gh-user=$USERNAME --gh-token=$TOKEN --gh-webhook-secret=$SECRET --repo-allowlist="github.com/mfakhriabdillah/bp-iac" --port=80
#   EOF
}

module "jenkins_instance" {
  source        = "./modules/compute_instance"
  instance_name = "jenkins-instance"
  machine_type  = "n1-standard-1"
  zone          = "us-central1-a"
  tags          = ["allow-ssh","allow-jenkins"]
  image         = "ubuntu-os-cloud/ubuntu-2004-lts"
  network       = module.bigpro_vpc.vpc_id
  subnet        = module.bigpro_subnet.subnet_id
  ssh_pubkey = "fakhri:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMKsCC8rJUvA8jwemWvMdk2RQ0VheM71DAXqi6tCqg8R8+DUp9p76GudmKOlIe/PnagAaJYTDSQDGujKfugiUObVDOlVrDL8wKrz3sTsXXeg7K8JUiDC4EAYrgf+MW2ETCf2mTKxF30pdU+7ZOLBKwH45spT1ZNyHOHpybG+k859zVzY87XKDsrPL8S1wfe6eET6TrXHuRPyPAkYqbLYseQtu2Ua132NioNcW68So356HTEsRHQrHnc7xHSFol+8NfGy/QRPiTy5zvYhqA8LzolX6K56I3nIA7dQ20GqxrKD+JtZPKEftRYQhPEqvlwPrD6vFV16ZImixNfT6108kbqxYjkbJFB9KK91D1PE2rQovJmYmAzQE8FEK4H7uIwfdr73wdlO0LmGmjopzUpEIxXrysUfhUItW48LjqZgxOxG/jVj4wIRKC7MhFrcLzxnMasZKcWgEWw/ohebRuhmP0tdh03rgb7Ihq09XuCER1Xtxukbg5TP91bjnLI4VDu/c= faseero0@mint"
  # desired_status = "TERMINATED"
}

# module "grafana_instance" {
#   source        = "./modules/compute_instance"
#   instance_name = "grafana-instance"
#   machine_type  = "n1-standard-1"
#   zone          = "us-central1-a"
#   tags          = ["allow-ssh","allow-grafana"]
#   image         = "ubuntu-os-cloud/ubuntu-2004-lts"
#   network       = module.bigpro_vpc.vpc_id
#   subnet        = module.bigpro_subnet.subnet_id
#   ssh_pubkey = "fakhri:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMKsCC8rJUvA8jwemWvMdk2RQ0VheM71DAXqi6tCqg8R8+DUp9p76GudmKOlIe/PnagAaJYTDSQDGujKfugiUObVDOlVrDL8wKrz3sTsXXeg7K8JUiDC4EAYrgf+MW2ETCf2mTKxF30pdU+7ZOLBKwH45spT1ZNyHOHpybG+k859zVzY87XKDsrPL8S1wfe6eET6TrXHuRPyPAkYqbLYseQtu2Ua132NioNcW68So356HTEsRHQrHnc7xHSFol+8NfGy/QRPiTy5zvYhqA8LzolX6K56I3nIA7dQ20GqxrKD+JtZPKEftRYQhPEqvlwPrD6vFV16ZImixNfT6108kbqxYjkbJFB9KK91D1PE2rQovJmYmAzQE8FEK4H7uIwfdr73wdlO0LmGmjopzUpEIxXrysUfhUItW48LjqZgxOxG/jVj4wIRKC7MhFrcLzxnMasZKcWgEWw/ohebRuhmP0tdh03rgb7Ihq09XuCER1Xtxukbg5TP91bjnLI4VDu/c= faseero0@mint"
#   desired_status = "TERMINATED"
# }

module "bp-db-instances" {
  source = "./modules/cloud_sql"
  instance_name = "bp-db-instance"
  database_version = "MYSQL_5_7"
  region = "us-central1"
  project_id = "studidevops-bigpro-fakhri"
  
  database_name = "db-prod"
  user_name = "people"
  passwd = "c0c0d0tB4u"
}

# module "kubernetes-cluster" {
#   source = "./modules/gke_cluster"
#   cluster_name = "bp-app-cluster"
#   region = "us-central1-c"
#   node_pool_name = "pool1"
#   initial_node_count = "2"
# }