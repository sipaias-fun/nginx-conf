FROM nginx:latest

# Copy custom NGINX configuration
COPY config /etc/nginx/conf.d
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Set execution permissions for the entrypoint script
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Set the entrypoint to the custom script
ENTRYPOINT ["docker-entrypoint.sh"]

# Continue with default NGINX CMD
CMD ["nginx", "-g", "daemon off;"]