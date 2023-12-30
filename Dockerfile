FROM nginx:latest

# Install Certbot and dependencies for envsubst
RUN apt update && \
    apt install -y certbot python3-certbot-nginx gettext-base && \
    rm -rf /var/lib/apt/lists/*

# Copy over the Nginx configuration templates and the entry script
COPY nginx.conf.tpl /etc/nginx/nginx.conf.tpl
COPY nginx.conf.ssl.tpl /etc/nginx/nginx.conf.ssl.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

CMD ["/entrypoint.sh"]
