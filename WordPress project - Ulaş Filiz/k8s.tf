resource "google_container_cluster" "primary" {
  name               = "myk8scluster"
  location           = var.gcp_region
  initial_node_count = 1

  network    = google_compute_network.myvpc.name
  subnetwork = google_compute_subnetwork.network.name

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
    
  }
 
}
