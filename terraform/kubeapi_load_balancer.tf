resource "google_compute_instance_group" "nevertowns" {
  name        = "nevertowns"
  description = "control planes nodes instance group"

  instances = (var.add_master_node_to_lb == "all_masters" ? [for name in var.master_nodes_name : module.nevertowns[name].self_link] : [module.nevertowns[var.master_nodes_name[0]].self_link])
  named_port {
    name = "https"
    port = "6443"
  }

  zone = "europe-west6-a"
}


resource "google_compute_health_check" "kubeapi-health-check" {
  name                = "kubeapi-health-check"
  timeout_sec         = 1
  check_interval_sec  = 1
  healthy_threshold   = 4
  unhealthy_threshold = 5
  tcp_health_check {
    port = "6443"
  }
}

# forwarding rule
resource "google_compute_forwarding_rule" "kubeapi-forwarding-rule" {
  name                  = "kubeapi-forwarding-rule"
  backend_service       = google_compute_region_backend_service.kubeapi-backend.id
  region                = "europe-west6"
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  network               = google_compute_network.neverland-gcn.id
  subnetwork            = google_compute_subnetwork.neverland-gcn-subnetwork.id
}

# backend service
resource "google_compute_region_backend_service" "kubeapi-backend" {
  name                  = "kubeapi-backend"
  region                = "europe-west6"
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_health_check.kubeapi-health-check.id]
  backend {
    group          = google_compute_instance_group.nevertowns.id
    balancing_mode = "CONNECTION"
  }
}

output "kubeapi_LBfrontend_IP" {
  value = google_compute_forwarding_rule.kubeapi-forwarding-rule.ip_address
}

resource "google_compute_firewall" "kubeapi-health-check-firewall" {
  name          = "kubeapi-health-check-firewall"
  direction     = "INGRESS"
  network       = google_compute_network.neverland-gcn.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
  }
  source_tags = ["k8s-master"]
}

