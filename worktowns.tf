module "worktowns" {
  source                = "./modules/gci"
  instance_name         = each.key
  instance_ansible_file = "playbook.yaml"
  ssh_user              = var.ssh_user
  for_each              = toset(var.worker_nodes_name)
}

output "worktowns-IPs" {
  value = {
    for name in var.worker_nodes_name : name => module.worktowns[name].ip
  }

}
