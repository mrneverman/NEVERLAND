/*
variable "worker_nodes_name" {
  type        = list(any)
  default     = ["worktown-1"]
  description = "Name of worker nodes"
}
*/
variable "worker_nodes_name" {
  type = list(any)
  default = ["worktown-1",
    "worktown-2",
    "worktown-3",
  "worktown-4"]
  description = "Name of worker nodes"
}

variable "vpc_cidr" {
  default     = "10.240.0.0/24"
  description = "VPC IP ranges"
}

variable "tinyproxy_port" {
  default     = "1234"
  description = "The port listened by tinyproxy"
}