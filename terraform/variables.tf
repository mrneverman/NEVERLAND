variable "worker_nodes_name" {
  type = list(any)
  default = ["worktown-1",
    "worktown-2",
    "worktown-3",
  "worktown-4"]
  description = "Name of worker nodes"
}

variable "infrastructure_nodes_name" {
  type = list(any)
  default = ["infratown-1",
  "infratown-2",
  "infratown-3",
  "infratown-4"]
  description = "Name of infrastructure nodes that will host monitoring, istio daemon and related pods. "
}



variable "vpc_cidr" {
  default     = "10.240.0.0/24"
  description = "VPC IP ranges"
}

variable "vpc_pod_cidr" {
  default     = "10.1.0.0/18"
  description = "VPC POD IP ranges"
}

variable "vpc_svc_cidr" {
  default     = "10.2.0.0/20"
  description = "VPC Service IP ranges"
}

variable "tinyproxy_port" {
  default     = "1234"
  description = "The port listened by tinyproxy"
}

variable "istioingressgateway_port" {
  default     = "31128"
  description = "The port listened by tinyproxy"
}

