resource "google_compute_instance" "port-of-neverland" {
  name         = "port-of-neverland"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = 25
      type  = "pd-ssd"
    }
  }

  tags = ["bastion"]

#  depends_on = [module.nevertown]

  network_interface {
    subnetwork = google_compute_subnetwork.neverland-gcn-subnetwork.id
    access_config {
    }
  }
  metadata = {
    ssh-keys = "fisherman:${file("../sensitive_data/fisherman.pub")}"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, -u fisherman --private-key ../sensitive_data/fisherman ../ansible/port-of-neverland_init.yaml"
  }

}

output "port-of-neverland-IP" {
  value = google_compute_instance.port-of-neverland.network_interface.0.access_config.0.nat_ip
}


