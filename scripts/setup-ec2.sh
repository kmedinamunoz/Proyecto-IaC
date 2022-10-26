#!/bin/bash

# INSTALL DOCKER AND ECR CREDENTIAL HELPER
# https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
# https://github.com/awslabs/amazon-ecr-credential-helper
apt update
apt -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin \
    amazon-ecr-credential-helper

# INSTALL DOCKER-COMPOSE
apt-get update
apt-get -y install docker-compose

# DOCKER PERMISSIONS
groupadd docker
usermod -aG docker ubuntu

# DOCKER-COMPOSE PERMISSIONS
chmod 666 /var/run/docker.sock

# INSTALL NANO
apt-get install nano

# DOCKER-COMPOSE FILE
cat << EOF >> /home/ubuntu/docker-compose.yaml
version: '3.8'

services:
  mysql:
    # We use a mariadb image which supports both amd64 & arm64 architecture
    # image: mariadb:10.6.4-focal
    # If you really want to use MySQL, uncomment the following line
    image: mysql:8.0.27
    container_name: mysql
    command: '--default-authentication-plugin=mysql_native_password'
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=myrootpassword
      - MYSQL_DATABASE=wordpress
      - MYSQL_USER=wordpress
      - MYSQL_PASSWORD=wordpress
    volumes:
      - db_data:/var/lib/mysql
    expose:
      - 3306
      - 33060
    networks:
      - wc-network

  wordpress:
    depends_on:
      - mysql
    image: wordpress:latest
    container_name: wordpress
    restart: always
    environment:
      - WORDPRESS_DB_HOST=mysql
      - WORDPRESS_DB_USER=wordpress
      - WORDPRESS_DB_PASSWORD=wordpress
      - WORDPRESS_DB_NAME=wordpress
    volumes:
      - wp_data:/var/www/html
    ports:
      - 8080:80
    networks:
      - wc-network

  nginx:
    depends_on:
      - wordpress
    image: nginx
    container_name: nginx
    restart: always
    volumes:
      - ./nginx:/etc/nginx/conf.d/
    ports:
      - 80:80
      - 443:443
    networks:
      - wc-network

volumes:
  db_data:
  wp_data:

networks:
  wc-network:
    driver: bridge
EOF

# NGINX.CONF FILE
sudo bash -c 'cat << EOF >> /home/ubuntu/nginx/nginx.conf
# server {
#     listen 80;
#     listen [::]:80;

#     # This defines your server name and the server block that should be used for requests to your server.
#     server_name _;

#     location / {
#         proxy_pass http://PUBLIC_IP:8080;
#      }
# }
EOF'

docker volume create db_data

docker-compose -f /home/ubuntu/docker-compose.yaml up -d