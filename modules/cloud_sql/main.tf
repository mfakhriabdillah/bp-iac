resource "google_sql_database_instance" "sql_instance" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  project          = var.project_id

  // Additional configuration options
}

resource "google_sql_database" "sql_database" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_instance.name

  // Additional configuration options
}
