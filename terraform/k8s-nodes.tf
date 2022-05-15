module "nevertowns" {
  source          = "./modules/gci"
  instance_name   = each.key
  ssh_user        = "kubeman"
  tags            = ["k8s-master", "internal"]
  subnetwork_name = google_compute_subnetwork.neverland-gcn-subnetwork.id
  for_each        = toset(var.master_nodes_name)
}

module "registertowns" {
  source          = "./modules/gci"
  instance_name   = each.key
  ssh_user        = "registerman"
  tags            = ["k8s-etcd", "internal"]
  subnetwork_name = google_compute_subnetwork.neverland-gcn-subnetwork.id
  for_each        = toset(var.etcd_nodes_name)
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
  tags            = ["k8s-infra", "internal"]
  subnetwork_name = google_compute_subnetwork.neverland-gcn-subnetwork.id
  for_each        = toset(var.infrastructure_nodes_name)
}

output "nevertowns-IPs" {
  value = {
    for name in var.master_nodes_name : name => module.nevertowns[name].ip
  }
}

output "registertowns-IPs" {
  value = {
    for name in var.etcd_nodes_name : name => module.registertowns[name].ip
  }
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

    nevertowns_internal_ip:
    %{for name in var.master_nodes_name~}
      - ${module.nevertowns[name].ip}
    %{endfor~}

    registertowns_internal_ip:
    %{for name in var.etcd_nodes_name~}
      - ${module.registertowns[name].ip}
    %{endfor~}

    worktowns_internal_ip:
    %{for name in var.worker_nodes_name~}
      - ${module.worktowns[name].ip}
    %{endfor~}

    infratowns_internal_ip:
    %{for name in var.infrastructure_nodes_name~}
      - ${module.infratowns[name].ip}
    %{endfor~}

    master_nodes:
    %{for name in var.master_nodes_name~}
      - "${name}"
    %{endfor~}

    etcd_nodes:
    %{for name in var.etcd_nodes_name~}
      - "${name}"
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

