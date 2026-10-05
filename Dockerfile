# Production Nginx Container for alpasec Security Terminal
FROM nginx:alpine

LABEL maintainer="soc@alpasec.cloud"
LABEL description="alpasec Security Access Terminal"

# Remove default static files
RUN rm -rf /usr/share/nginx/html/*

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy application web assets
COPY . /usr/share/nginx/html/

# Expose standard HTTP port
EXPOSE 80

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]