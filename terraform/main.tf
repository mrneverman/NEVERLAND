module "nevertown" {
  source                = "./modules/gci"
  instance_name         = "nevertown"
  ssh_user              = var.ssh_user
  tags                  = ["k8s-master", "internal"]
  subnetwork_name       = google_compute_subnetwork.neverland-gcn-subnetwork.id
}

module "worktowns" {
  source                = "./modules/gci"
  instance_name         = each.key
  ssh_user              = var.ssh_user
  tags                  = ["k8s-worker", "internal"]
  subnetwork_name       = google_compute_subnetwork.neverland-gcn-subnetwork.id
  for_each              = toset(var.worker_nodes_name)
}

module "island-of-intelligence" {
  source                = "./modules/gci"
  instance_name         = "island-of-intelligence"
  ssh_user              = var.ssh_user
  tags                  = ["ioi", "internal"]
  subnetwork_name       = "module.neverland_network"
}

