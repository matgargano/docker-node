#!/bin/bash

# Replace environment variables in the Nginx non-SSL configuration template
envsubst '$DOMAIN_NAME' < /etc/nginx/nginx.conf.tpl > /etc/nginx/nginx.conf

# Remove worker_processes directive from default.conf
sed -i '/worker_processes/d' /etc/nginx/conf.d/default.conf

# Start Nginx with the initial non-SSL configuration
nginx &

# Wait for a brief moment to ensure Nginx is up
sleep 5

# Obtain the SSL certificate
certbot --nginx -d $DOMAIN_NAME -m $EMAIL --agree-tos --no-eff-email --keep-until-expiring --redirect --non-interactive

# Stop Nginx
nginx -s stop

# Replace environment variables in the Nginx SSL configuration template
envsubst '$DOMAIN_NAME' < /etc/nginx/nginx.conf.ssl.tpl > /etc/nginx/nginx.conf

# Restart Nginx with SSL configuration
nginx -g 'daemon off;'
