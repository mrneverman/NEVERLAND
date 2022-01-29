module "port-of-neverland" {
  source                = "./modules/gci"
  instance_name         = "port-of-neverland"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
}

output "port_of_neverland-IP" {
  value = module.port-of-neverland.ip
}

