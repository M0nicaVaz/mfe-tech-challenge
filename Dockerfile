FROM node:18-alpine AS base

WORKDIR /app

# Pre-copy package manifests for better layer caching
COPY home/package*.json home/
COPY login/package*.json login/
COPY shared/package*.json shared/
# Ensure local package content is present for file: install
COPY shared shared

# Install dependencies for each zone (local file deps supported)
RUN cd home && npm install && cd ../login && npm install

# Copy source code
COPY home home
COPY login login
COPY start.sh start.sh

# Expose ports used by zones
EXPOSE 7777 4444

# Configure env for login -> home rewrites
# Allow override at build-time or run-time
ARG NEXT_PUBLIC_HOME_URL=http://localhost:4444
ENV NEXT_PUBLIC_HOME_URL=${NEXT_PUBLIC_HOME_URL}

# Make script executable and start both zones
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
