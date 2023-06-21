variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "Region where the GKE cluster will be created"
  type        = string
}

variable "node_pool_name" {
  description = "Name of the GKE node pool"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the GKE nodes"
  type        = string
}

variable "initial_node_count" {
  description = "Initial number of nodes in the GKE node pool"
  type        = number
}
