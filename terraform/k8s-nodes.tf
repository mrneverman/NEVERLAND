module "nevertown" {
  source          = "./modules/gci"
  instance_name   = "nevertown"
  ssh_user        = "kubeman"
  tags            = ["k8s-master", "internal"]
  subnetwork_name = google_compute_subnetwork.neverland-gcn-subnetwork.id
}

module "worktowns" {
  source          = "./modules/gci"
  instance_name   = each.key
  ssh_user        = "kubeman"
  tags            = ["k8s-worker", "internal"]
  subnetwork_name = google_compute_subnetwork.neverland-gcn-subnetwork.id
  for_each        = toset(var.worker_nodes_name)
}

module "infratowns" {
  source          = "./modules/gci"
  instance_name   = each.key
  ssh_user        = "kubeman"
  tags            = ["k8s-worker", "internal", "infratown"]
  subnetwork_name = google_compute_subnetwork.neverland-gcn-subnetwork.id
  for_each        = toset(var.infrastructure_nodes_name)
}

output "nevertown-IP" {
  value = module.nevertown.ip
}

output "worktowns-IPs" {
  value = {
    for name in var.worker_nodes_name : name => module.worktowns[name].ip
  }

}

output "infratowns-IPs" {
  value = {
    for name in var.infrastructure_nodes_name : name => module.infratowns[name].ip
  }

}

/* Ansible variables */
resource "local_file" "tf_k8node_vars_file_new" {
  content  = <<-DOC
    # Ansible vars_file containing variable values from Terraform.
    # Generated by Terraform mgmt configuration.
    nevertown_internal_ip: ${module.nevertown.ip}
    worktowns_internal_ip:
    %{for name in var.worker_nodes_name~}
      - ${module.worktowns[name].ip}
    %{endfor~}

    infratowns_internal_ip:
    %{for name in var.infrastructure_nodes_name~}
      - ${module.infratowns[name].ip}
    %{endfor~}

    worker_nodes:
    %{for name in var.worker_nodes_name~}
      - "${name}"
    %{endfor~}

    infrastructure_nodes:
    %{for name in var.infrastructure_nodes_name~}
      - "${name}"
    %{endfor~}

    DOC
  filename = "../ansible/terraform_variables/tf_k8node_vars_file.yml"
}

