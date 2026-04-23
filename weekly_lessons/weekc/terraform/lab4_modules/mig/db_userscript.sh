metadata_startup_script = <<-EOT
#!/bin/bash

apt-get update -y
apt-get install -y nginx postgresql-client google-cloud-cli

# Chewbacca (bad)
export PGPASSWORD="supersecret123"

# Han (good)
HAN_PASSWORD=$(gcloud secrets versions access latest --secret="han-db-password")

# Test both connections

echo "Testing Chewbacca..."
psql -h ${var.db_host} -U chewie -d ${var.db_name} -c '\l'

echo "Testing Han..."
PGPASSWORD=$HAN_PASSWORD psql -h ${var.db_host} -U han -d ${var.db_name} -c '\l'

echo "🔥 Han vs Chewbacca lab running" > /var/www/html/index.html
EOT
