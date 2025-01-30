# Use a multi-arch base image
FROM debian:stable-slim

# Install dependencies and HandBrake CLI
RUN apt-get update && apt-get install -y \
    handbrake-cli \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /data

# Copy HandBrake presets into the container
COPY presets/*.json /root/.config/HandBrake/

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
