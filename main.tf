provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-bucket"
  location = var.region
}

resource "google_cloudfunctions_function" "function" {
  name        = "hello-world-function"
  runtime     = "python39"
  entry_point = "hello_world"
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = "function-source.zip"
  trigger_http = true
}
