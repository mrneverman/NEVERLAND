resource "local_file" "ansible_inventory" {
  content = templatefile("./ansible_inventory.tpl",
    {
      portOfNeverlandIP      = google_compute_instance.port-of-neverland.network_interface.0.access_config.0.nat_ip,
      islandOfIntelligenceIP = google_compute_instance.island-of-intelligence.network_interface.0.access_config.0.nat_ip,
      nevertownIP = module.nevertown.ip
      worktownsIP = {
        for name in var.worker_nodes_name : name => module.worktowns[name].ip
      }

    }
  )
  filename = "../ansible/inventory.cfg"
}
