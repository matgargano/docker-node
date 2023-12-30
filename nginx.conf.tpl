user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    keepalive_timeout  65;

    # Initial server block for HTTP
    server {
        listen 80;
        server_name ${DOMAIN_NAME};

        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
        }

        # Location for the ACME challenge
        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }
    }

    # Include additional configurations
    include /etc/nginx/conf.d/*.conf;
}
