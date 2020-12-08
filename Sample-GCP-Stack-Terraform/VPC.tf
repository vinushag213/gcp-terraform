
resource "google_compute_network" "vpc" {
  name                    = "${var.app_name}-${var.app_environment}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "public_subnet_1" {
     purpose       = "PUBLIC"
     name          = "${var.app_name}-${var.app_environment}-public-subnet-1"
     ip_cidr_range = var.public_subnet_cidr_1
     network       = google_compute_network.vpc.name
     region        = var.gcp_region_1
    }
	
resource "google_compute_subnetwork" "public_subnet_2" {
     purpose       = "PUBLIC"
     name          = "${var.app_name}-${var.app_environment}-public-subnet-2"
     ip_cidr_range = var.public_subnet_cidr_2
     network       = google_compute_network.vpc.name
     region        = var.gcp_region_1
    }

resource "google_compute_subnetwork" "private_subnet_1" {
  purpose       = "PRIVATE"
  name          = "${var.app_name}-${var.app_environment}-private-subnet-1"
  ip_cidr_range = var.private_subnet_cidr_1
  network       = google_compute_network.vpc.name
  region        = var.gcp_region_1
}

resource "google_compute_subnetwork" "private_subnet_2" {
  purpose       = "PRIVATE"
  name          = "${var.app_name}-${var.app_environment}-private-subnet-2"
  ip_cidr_range = var.private_subnet_cidr_001
  network       = google_compute_network.vpc.name
  region        = var.gcp_region
}

resource "google_compute_address" "nat_ip" {
  name    = "${var.app_name}-${var.app_environment}-nap-ip"
  project = var.app_project
  region  = var.gcp_region
}


resource "google_compute_router" "nat-router" {
  name    = "${var.app_name}-${var.app_environment}-nat-router"
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat-gateway" {
  name                               = "${var.app_name}-nat-gateway"
  router                             = google_compute_router.nat_router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [ google_compute_address.nat_ip.self_link ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on                         = [ google_compute_address.nat_ip ]
}

output "nat_ip_address" {
  value = google_compute_address.nat_ip.address
}

resource "google_compute_firewall" "allow-internal" {
  name    = "${var.app_name}-${var.app_environment}-fw-allow-internal"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "${var.private_subnet_cidr_001}", "${var.private_subnet_cidr_002}"
  ]
}
