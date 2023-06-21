variable "project_id" {
  type = string
}

variable "firewall_rule_id" {
  type = string
}

variable "ports_allow" {
  type = list(string)
}

variable "target_tags_id" {
  type = list(string)
}

variable "network_id" {
  type = string
}