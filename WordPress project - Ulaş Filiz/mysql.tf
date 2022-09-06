resource "google_sql_database" "database" {

  name     = "my-database1"
  instance =  google_sql_database_instance.db_instance.name
  project  =  var.devops-project
}

resource "google_sql_database_instance" "db_instance" {

  name             = "my-database-instance"
  database_version = "MYSQL_5_6"
  region           = "us-central1"
  project          = var.devops-project
  settings {

    tier = "db-f1-micro"
    backup_configuration {
      binary_log_enabled = true
      enabled = true
    }
    availability_type = "REGIONAL"
    ip_configuration {

      ipv4_enabled = true
      authorized_networks {

        name = "public  network"
        value = "0.0.0.0/0"
      }
    }
  }
}
resource "google_sql_user" "users" {

  name     = var.db-user
  instance = google_sql_database_instance.db_instance.name
  project  =  var.devops-project
  password = var.db-pass
}
