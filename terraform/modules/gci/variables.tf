variable "instance_name" {
  type        = string
  description = "Compute instance name"
}


variable "ssh_user" {
  type        = string
  description = "ssh user name"
}


variable "subnetwork_name" {
  /*  type = string */
  description = "gci subnetwork name"
}

variable "tags" {
  description = "gci tags"

}

variable "instance_ansible_file" {
  description = " name of the ansible file which will be run once the instance created"
}

variable "bastion_ip" {
  description = "bastion ip for ssh proxy jump"

}
