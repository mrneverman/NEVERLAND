module "island-of-intelligence" {
  source                = "./modules/gci"
  instance_name         = "island-of-intelligence"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
  
  depends_on = [ module.nevertown,  module.worktowns,  module.port-of-neverland ]
}

output "island-of-intelligence-IP" {
  value = module.island-of-intelligence.ip
}

