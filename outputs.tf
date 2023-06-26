
output "jenkins_instance_ip" {
  description = "IP address of the Jenkins instance"
  value       = module.jenkins_instance.instance_ip
}

# output "grafana_instance_ip" {
#   description = "IP address of the Grafana instance"
#   value       = module.grafana_instance.instance_ip
# }

output "bastion_instance_ip" {
  description = "IP address of the Grafana instance"
  value       = module.devops_bastion.instance_ip
}