output "nevertown-IP" {
  value = module.nevertown.ip
}


output "worktowns-IPs" {
  value = {
    for name in var.worker_nodes_name : name => module.worktowns[name].ip
  }

}

output "island-of-intelligence-IP" {
  value = module.island-of-intelligence.ip
}

output "port-of-neverland-IP" {
  value = google_compute_instance.port-of-neverland.network_interface.0.access_config.0.nat_ip
}


