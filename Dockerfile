FROM debian:bookworm

# Install build dependencies
RUN apt-get update && apt-get install -y \
    debootstrap \
    xorriso \
    grub-pc-bin \
    grub-efi-amd64-bin \
    mtools \
    python3 \
    python3-pip \
    sudo \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Pillow for wallpaper generation
RUN pip3 install Pillow

# Set working directory
WORKDIR /build

# Copy project files
COPY . /build/

# Make scripts executable
RUN chmod +x *.sh *.py

# Build ISO
CMD ["sudo", "./create-iso.sh"]
