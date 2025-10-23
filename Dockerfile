# Use the latest long-term support Node.js image (Debian 12 - Bookworm)
FROM node:lts-bookworm

# Prevents prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required system packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        imagemagick \
        webp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package.json first for dependency caching
COPY package.json .

# Install dependencies
RUN npm install && npm install -g qrcode-terminal pm2

# Copy the rest of the application
COPY . .

# Expose the app port
EXPOSE 5000

# Start the app
CMD ["npm", "start"]
