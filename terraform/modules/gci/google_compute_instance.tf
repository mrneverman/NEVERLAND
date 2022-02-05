resource "google_compute_instance" "gci" {
  name         = var.instance_name
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = 25
      type  = "pd-ssd"
    }
  }

  tags = var.tags

  network_interface {
    subnetwork = var.subnetwork_name
    /* 
   access_config {
    }
*/
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("../sensitive_data/kubeman.pub")}"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ${self.network_interface.0.network_ip}, -u kubeman --private-key ./sensitive_data/kubeman --ssh-common-args '-o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o 'ForwardAgent yes' -i /root/NEVERLAND/sensitive_data/fisherman -W %h:%p fisherman@${var.bastion_ip}\"' ${var.instance_ansible_file}"
  }
}

output "ip" {
  value = google_compute_instance.gci.network_interface.0.network_ip
}

