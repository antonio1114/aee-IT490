#!/bin/bash
set -e # Exit on error

echo "=== IT490 Setup ==="

# 1. Install system dependencies
echo updating and installing system packages
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
    unzip \
    php \
    composer \
    nano \
    rabbitmq-server \
    net-tools \
    openssh-server

# 2. Download zip from repo
echo downloading project files
wget -q https://github.com/MattToegel/IT490/archive/refs/heads/master.zip -O master.zip
unzip -q master.zip
cd IT490-master

# 3. Install PHP dependencies
echo installing php dependencies
composer install
composer update

# 4. Configure services
echo configuring services
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl start ssh
sudo systemctl enable ssh

# 5. Set perms
echo setting perms
sudo chown -R $USER:$USER .

# 6. Completion
echo "Setup complete [Final]"
echo ""

cat <<EOF
=== Next Steps From Individual Setup ===
1. Open MAC Terminal
2. Connect SSH IP
3. Run php RabbitMQClientSample.php on MAC terminal
4. Run php RabbitMQServerSample.php on Ubuntu terminal
EOF
