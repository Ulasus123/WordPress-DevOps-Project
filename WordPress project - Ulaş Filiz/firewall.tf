resource "google_compute_firewall" "rule" {
  name    = "myfirewall"
  network = google_compute_network.myvpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_tags = ["web"]
}
