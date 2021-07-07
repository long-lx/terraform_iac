provider "google" {
 credentials = file("../credentials/techmaster-04d5d76222fb.json")
 project     = "techmaster-305714"
 region      = "us-west1"
}

resource "google_sql_database_instance" "pg-01" {
  name             = "pg-01"
  database_version = "POSTGRES_11"
  region           = "us-west1"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "app-01"
  instance = google_sql_database_instance.pg-01.name
  password = "change-me-now"
}