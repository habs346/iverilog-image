# Use Ubuntu as the base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    iverilog \
    gtkwave \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /work

# Create a non-root user
RUN useradd -m -s /bin/bash verilog_user
USER verilog_user

# Default command
CMD ["/bin/bash"]