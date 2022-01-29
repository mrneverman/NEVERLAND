variable "instance_name" {
  type        = string
  description = "Compute instance name"
}

variable "instance_ansible_file" {
  type        = string
  description = "Name of the ansible yaml file. ex.: nodeload.yaml"
}

variable "ssh_user" {
  type = string
  description = "ssh user name"
}
