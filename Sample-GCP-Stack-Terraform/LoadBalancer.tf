resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name       = "${var.app_name}-${var.app_environment}-global-forwarding-rule"
  project    = var.app_project
  target     = google_compute_target_http_proxy.target_http_proxy.self_link
  port_range = "80"
}

resource "google_compute_target_http_proxy" "target_http_proxy" {
  name    = "${var.app_name}-${var.app_environment}-proxy"
  project = var.app_project
  url_map = google_compute_url_map.url_map.self_link
}


resource "google_compute_backend_service" "backend_service" {
  name                    = "${var.app_name}-${var.app_environment}-backend-service"
  project                 = "${var.app_project}"
  port_name               = "http"
  protocol                = "HTTP"
  health_checks           = ["${google_compute_health_check.healthcheck.self_link}"]

  backend {
    group                 = google_compute_instance_group.web_private_group.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }
}


resource "google_compute_instance_group" "web_private_group" {
  name        = "${var.app_name}-${var.app_environment}-vm-group"
  description = "Web servers instance group"
  zone        = var.gcp_zone_1
  
  instances   = [ 
    google_compute_instance.web_server_001.self_link,
    google_compute_instance.web_server_002.self_link
    ]

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_health_check" "healthcheck" {
  name               = "${var.app_name}-${var.app_environment}-healthcheck"
  timeout_sec        = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}


resource "google_compute_url_map" "url_map" {
  name            = "${var.app_name}-${var.app_environment}-load-balancer"
  project         = var.app_project
  default_service = google_compute_backend_service.backend_service.self_link
}


output "load-balancer-ip-address" {
  value = google_compute_global_forwarding_rule.global_forwarding_rule.ip_address
}
