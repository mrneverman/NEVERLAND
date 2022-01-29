/*
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = "${file("./sensitive_data/gcloud.pub")}"
}
*/
resource "google_compute_instance" "port-neverland" {
  name         = "port-neverland"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = 25
      type  = "pd-standard"
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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, -u ${var.ssh_user} --private-key ./sensitive_data/gcloud.private playbook.yaml"
  }
}

output "port-neverland-ip" {
  value = google_compute_instance.port-neverland.network_interface.0.access_config.0.nat_ip
}
