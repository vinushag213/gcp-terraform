resource "google_compute_firewall" "allow-http-traffic" {
  name    = "${var.app_name}-${var.app_environment}-ingress-allow-http"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http-traffic"] 
}

resource "google_compute_firewall" "allow-https-traffic" {
  name    = "${var.app_name}-${var.app_environment}-ingress-allow-https"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["https-traffic"] 
}

resource "google_compute_firewall" "allow-ssh-traffic" {
  name    = "${var.app_name}-${var.app_environment}-ingress-allow-ssh"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh-traffic"]
}

