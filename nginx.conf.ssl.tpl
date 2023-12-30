worker_processes auto;

events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    server {
        listen 443 ssl;
        server_name ${DOMAIN_NAME}; # Use the DOMAIN_NAME environment variable

        ssl_certificate /path/to/your/certificate.crt; # Replace with your SSL certificate
        ssl_certificate_key /path/to/your/private.key; # Replace with your SSL certificate key
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers 'HIGH:!aNULL:!MD5';

        location / {
            proxy_pass http://localhost:${PORT}; # Use the PORT environment variable
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
    }

    include /etc/nginx/conf.d/*.conf;
}
