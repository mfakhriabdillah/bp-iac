variable "instance_name" {
  description = "Name of the Compute Instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the Compute Instance"
  type        = string
}

variable "zone" {
  description = "Zone where the Compute Instance will be provisioned"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the Compute Instance"
  type        = list(string)
}

variable "image" {
  description = "Operating system image for the Compute Instance"
  type        = string
}

variable "network" {
  description = "Name or self_link of the network to attach the Compute Instance"
  type        = string
}

variable "subnet" {
  description = "Name or self_link of the subnetwork to attach the Compute Instance"
  type        = string
}

variable "ssh_pubkey" {
  type = string
}

variable "desired_status" {
  type = string
  default = "RUNNING"
}