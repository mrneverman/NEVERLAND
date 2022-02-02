variable "instance_name" {
  type        = string
  description = "Compute instance name"
}


variable "ssh_user" {
  type = string
  description = "ssh user name"
}


variable "subnetwork_name" { 
/*  type = string */
  description = "gci subnetwork name"
}

variable "tags" {
  description = "gci tags"

}

