resource "google_compute_instance" "gci" {
  name         = var.instance_name
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = 25
      type  = "pd-ssd"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("./sensitive_data/gcloud.pub")}"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, -u ${var.ssh_user} --private-key ./sensitive_data/gcloud.private ${var.instance_ansible_file}"
  }
}

output "ip" {
  value =  google_compute_instance.gci.network_interface.0.access_config.0.nat_ip
}

