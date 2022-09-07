provider "google" {
  project     = "dev-project-361620"
  credentials =  file("foo.json") # There should be your credential information.
  region      = "us-central1"
}
