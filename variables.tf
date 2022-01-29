variable "worker_nodes_name" {
  type = list(any)
  default = ["worktown-1",
    "worktown-2",
  "worktown-3",
  "worktown-4"]
  description = "Name of worker nodes"
}
