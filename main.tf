module "nevertown" {
  source                = "./terraform/modules/gci"
  instance_name         = "nevertown"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
}

output "nevertown-IP" {
  value = module.nevertown.ip
}

module "worktowns" {
  source                = "./terraform/modules/gci"
  instance_name         = each.key
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
  for_each              = toset(var.worker_nodes_name)
  
  depends_on = [ module.nevertown]
}

output "worktowns-IPs" {
  value = {
    for name in var.worker_nodes_name : name => module.worktowns[name].ip
  }

}
module "port-of-neverland" {
  source                = "./terraform/modules/gci"
  instance_name         = "port-of-neverland"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
  
  depends_on = [ module.nevertown,  module.worktowns ]

}

output "port_of_neverland-IP" {
  value = module.port-of-neverland.ip
}

module "island-of-intelligence" {
  source                = "./terraform/modules/gci"
  instance_name         = "island-of-intelligence"
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
  
  depends_on = [ module.nevertown,  module.worktowns,  module.port-of-neverland ]
}

output "island-of-intelligence-IP" {
  value = module.island-of-intelligence.ip
}
