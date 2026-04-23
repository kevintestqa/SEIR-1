metadata_startup_script = <<-EOT
  #!/bin/bash

  apt-get update -y
  apt-get install -y nginx postgresql-client

  echo "DB_HOST=${var.db_host}" >> /etc/environment
  echo "DB_NAME=${var.db_name}" >> /etc/environment
  echo "DB_USER=${var.db_user}" >> /etc/environment

  export PGPASSWORD="${var.db_password}"

  # Test DB connection
  psql -h ${var.db_host} -U ${var.db_user} -d ${var.db_name} -c '\l'

  echo "🔥 MIG + DB connected" > /var/www/html/index.html
EOT
