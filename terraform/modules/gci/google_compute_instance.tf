resource "google_compute_instance" "gci" {
  name         = var.instance_name
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size  = 20
      type  = "pd-ssd"
    }
  }

  tags = var.tags

  network_interface {
    subnetwork = var.subnetwork_name
    /* disabled not to have public ip
   access_config {
    }
*/
  }
  metadata = {
    ssh-keys = "${var.ssh_user}:${file("../sensitive_data/${var.ssh_user}.pub")}"
  }
}

output "ip" {
  value = google_compute_instance.gci.network_interface.0.network_ip
}

