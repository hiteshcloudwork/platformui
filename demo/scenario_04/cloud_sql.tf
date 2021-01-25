# Create a SQL Database and DB instance

resource "google_sql_database_instance" "db_instance" {
  name             = "postgresmaster"
  database_version = "POSTGRES_11"

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

resource "google_sql_database" "database" {
  name     = "user"
  instance = google_sql_database_instance.db_instance.name
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "google_sql_user" "users" {
  name     = "cloud_ui_user"
  instance = google_sql_database_instance.db_instance.name
  host     = "*"
  password = random_password.password.result
}
