resource "google_compute_network" "neverland-gcn" {
  name                    = "neverland-gcn"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "neverland-gcn-subnetwork" {
  name          = "neverland-gcn-subnetwork"
  ip_cidr_range = "10.240.0.0/24"
  region        = "europe-west6"
  network       = google_compute_network.neverland-gcn.id
}

resource "google_compute_firewall" "ssh" {
  name    = "firewall-ssh"
  network = google_compute_network.neverland-gcn.id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["internal"]
  source_ranges = ["0.0.0.0/0"]
}
