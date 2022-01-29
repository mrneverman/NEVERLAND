module "island-of-intelligence" {
  source                = "./modules/gci"
  instance_name         = "island-of-intelligence"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
}

output "island-of-intelligence-IP" {
  value = module.island-of-intelligence.ip
}

