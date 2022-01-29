module "nevertown" {
  source                = "./modules/gci"
  instance_name         = "nevertown"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
}

output "nevertown-IP" {
  value = module.nevertown.ip
}

