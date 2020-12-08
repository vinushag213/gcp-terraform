resource "google_compute_instance" "web_server_001" {
  name         = "${var.app_name}-${var.app_environment}-001"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  hostname     = "${var.app_name}-${var.app_environment}-001.${var.app_domain}"
  tags         = ["ssh","http"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq apache2; sudo service apache2 restart"
  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.private_subnet_001.name
  }
} 

resource "google_compute_instance" "web_server_002" {
  name         = "${var.app_name}-${var.app_environment}-002"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  hostname     = "${var.app_name}-${var.app_environment}-002.${var.app_domain}"
  tags         = ["ssh","http"]
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq apache2; sudo service apache2 restart"
  network_interface {
    network       = google_compute_network.vpc.name
    subnetwork    = google_compute_subnetwork.private_subnet_002.name
  }
} 
