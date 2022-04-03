resource "google_compute_firewall" "allow-goldilocks-dashboard" {
  name    = "allow-goldilocks-dashboard"
  network = google_compute_network.neverland-gcn.id

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags   = ["bastion"]
  source_ranges = ["0.0.0.0/0"]
}

