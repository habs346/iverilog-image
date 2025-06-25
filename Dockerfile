# Use Ubuntu as the base image
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    gperf \
    flex \
    bison \
    gtkwave \
    wget \
    autoconf \
    && rm -rf /var/lib/apt/lists/*

# Build and install Icarus Verilog v12.0
RUN cd /tmp && \
    wget https://github.com/steveicarus/iverilog/archive/refs/tags/v12_0.tar.gz && \
    tar -zxvf v12_0.tar.gz && \
    cd iverilog-12_0 && \
    sh autoconf.sh && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/*

# Set working directory
WORKDIR /work

# Create a non-root user
RUN useradd -m -s /bin/bash verilog_user
USER verilog_user

# Default command
CMD ["/bin/bash"]