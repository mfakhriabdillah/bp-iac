resource "google_sql_database_instance" "sql_instance" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  project          = var.project_id

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }

  // Additional configuration options
}

resource "google_sql_database" "sql_database" {
  name     = var.database_name
  instance = google_sql_database_instance.sql_instance.name

  // Additional configuration options
}

resource "google_sql_user" "users" {
  name     = var.user_name
  instance = google_sql_database_instance.sql_instance.name
  password = var.passwd
}